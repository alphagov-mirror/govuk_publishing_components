module GovukPublishingComponents
  module Presenters
    class FaqPageSchema
      attr_reader :page

      def initialize(page)
        @page = page
      end

      def structured_data
        # http://schema.org/FAQPage
        data = CreativeWorkSchema.new(@page).structured_data
          .merge(main_entity)
        data["@type"] = "FAQPage"
        data
      end

    private

      def main_entity
        {
          "mainEntity" => questions_and_answers_markup,
        }
      end

      def questions_and_answers_markup
        question_and_answers.select { |_, value| value[:answer].present? }
                            .map do |question, value|
          q_and_a_url = section_url(value[:anchor])

          {
            "@type" => "Question",
            "name" => question,
            "url" => q_and_a_url,
            "acceptedAnswer" => {
              "@type" => "Answer",
              "url" => q_and_a_url,
              "text" => value[:answer],
            },
          }
        end
      end

      # Generates a hash of questions and associated information:
      # - question: the text in the h2 tag preceding other markup. Questions are
      #             used to key the hash. The page title is set as the default, as
      #             there is often a preamble in guides before any h2 is set.
      #
      # - :answer: the markup that is not an h2 tag. It is associated with the
      #            preceding h2 header.
      #
      # - :anchor: the id of the h2 (autogenerated by the markdown converter).
      #            This is used to build links directly to the section in question
      def question_and_answers
        question = page.title

        doc.xpath("html/body").children.each_with_object({}) do |element, q_and_as|
          if question_element?(element)
            question = element.text
            q_and_as[question] = { anchor: element["id"] }
          elsif question_hash_is_unset?(q_and_as, question)
            q_and_as[question] = { answer: element.to_s }
          elsif answer_is_unset?(q_and_as, question)
            q_and_as[question][:answer] = element.to_s
          else
            q_and_as[question][:answer] << element.to_s
          end
        end
      end

      def doc
        @doc ||= Nokogiri::HTML(page.body)
      end

      def question_hash_is_unset?(q_and_as, question)
        q_and_as[question].nil?
      end

      def answer_is_unset?(q_and_as, question)
        !q_and_as[question].key?(:answer)
      end

      # we use H2 tags as the "question" and the html between them as the "answer"
      QUESTION_TAG = "h2".freeze

      def question_element?(element)
        element.name == QUESTION_TAG
      end

      def section_url(anchor)
        return page_url + "#" + anchor if anchor.present?

        page_url
      end

      def page_url
        Plek.new.website_root + page.base_path
      end
    end
  end
end
