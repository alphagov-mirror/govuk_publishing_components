module GovukPublishingComponents
  module Presenters
    class ContentBreadcrumbsBasedOnPriority
      # keys are labels, values are the content_ids for the matching taxons
      # Where multiple matching taxons are present, the top most one is the highest priority
      #   and the bottom one the lowest priority
      PRIORITY_TAXONS = {
        education_coronavirus: "272308f4-05c8-4d0d-abc7-b7c2e3ccd249",
        business_coronavirus:  "65666cdf-b177-4d79-9687-b9c32805e450",
        coronavirus:           "5b7b9532-a775-4bd2-a3aa-6ce380184b6c"
      }

      # Returns the highest priority taxon that has a content_id matching those in PRIORITY_TAXONS
      def self.call(content_item)
        new(content_item).taxon
      end

      attr_reader :content_item

      def initialize(content_item)
        @content_item = content_item
      end

      def taxon
        @taxon ||= priority_taxons.sort_by { |t| PRIORITY_TAXONS.values.index(t['content_id']) }.first
      end

      private

      def priority_taxons
        taxons = content_item.dig("links", "taxons")&.map do |taxon|
          taxon.dig("links", "parent_taxons")&.select do |parent_taxon|
            PRIORITY_TAXONS.values.include?(parent_taxon['content_id'])
          end
        end
        return [] unless taxons

        taxons.flatten!
        taxons
      end
    end
  end
end
