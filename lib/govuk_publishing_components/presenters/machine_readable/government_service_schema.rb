module GovukPublishingComponents
  module Presenters
    class GovernmentServiceSchema
      attr_reader :page

      def initialize(page)
        @page = page
      end

      def structured_data
        # http://schema.org/GovernmentService
        {
          "@context" => "http://schema.org",
          "@type" => "GovernmentService",
          "name" => page.title,
          "serviceType" => page.description,
          "description" => description,
          "url" => page.canonical_url
        }
          .merge(provider)
          .merge(related_services)
      end

    private

      def related_services
        related_links = page.content_item.dig('links', 'ordered_related_items')

        return {} unless related_links.present?

        {
          "isRelatedTo" => related_links.each_with_object([]) do |link, items|
            if link['schema_name'] == 'transaction'
              items << {
                "@type" => "GovernmentService",
                "name" => link['title'],
                "url" => link['web_url']
              }
            end
          end
        }
      end

      def provider
        organisations = page.content_item.dig('links', 'organisations')

        return {} unless organisations.present?

        organisation = organisations.first

        {
          "provider" => {
            "@type" => "GovernmentOrganization",
            "name" => organisation['title'],
            "url" => organisation['web_url']
          }
        }
      end

      def description
        [introductory_paragraph, more_information].reject(&:blank?).join(' ')
      end

      def introductory_paragraph
        page.content_item.dig('details', 'introductory_paragraph')
      end

      def more_information
        page.content_item.dig('details', 'more_information')
      end
    end
  end
end
