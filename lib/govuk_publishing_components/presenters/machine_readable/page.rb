module GovukPublishingComponents
  module Presenters
    class Page
      attr_reader :local_assigns

      def initialize(local_assigns)
        @local_assigns = local_assigns
      end

      def schema
        local_assigns.fetch(:schema)
      end

      def canonical_url
        local_assigns[:canonical_url] || (Plek.current.website_root + content_item["base_path"])
      end

      def body
        local_assigns[:body] || content_item["details"]["body"]
      end

      def title
        local_assigns[:title] || content_item["title"]
      end

      def description
        content_item["description"]
      end

      def has_image?
        content_item.dig("details", "image").present?
      end

      def image_url
        content_item.dig("details", "image", "url")
      end

      def image_alt_text
        content_item.dig("details", "image", "alt_text")
      end

      def content_item
        local_assigns[:content_item]
      end
    end
  end
end
