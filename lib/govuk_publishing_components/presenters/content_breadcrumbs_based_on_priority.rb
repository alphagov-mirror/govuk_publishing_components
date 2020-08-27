module GovukPublishingComponents
  module Presenters
    class ContentBreadcrumbsBasedOnPriority
      # keys are labels, values are the content_ids for the matching taxons
      # Where multiple matching taxons are present, the top most one is the highest priority
      #   and the bottom one the lowest priority
      PRIORITY_TAXONS = {
        education_coronavirus: "272308f4-05c8-4d0d-abc7-b7c2e3ccd249",
        worker_coronavirus: "b7f57213-4b16-446d-8ded-81955d782680",
        business_coronavirus: "65666cdf-b177-4d79-9687-b9c32805e450",
        transition_period: "d6c2de5d-ef90-45d1-82d4-5f2438369eea",
      }.freeze

      # Returns the highest priority taxon that has a content_id matching those in PRIORITY_TAXONS
      def self.call(content_item, query_parameters = nil)
        new(content_item, query_parameters).breadcrumbs
      end

      attr_reader :content_item, :query_parameters

      def initialize(content_item, query_parameters = nil)
        @content_item = content_item
        @query_parameters = query_parameters
      end

      def taxon
        @taxon ||= begin
          default_taxon = priority_taxons.min_by { |t| PRIORITY_TAXONS.values.index(t["content_id"]) }
          preferred_taxon || default_taxon
        end
      end

      def breadcrumbs
        taxon && {
          title: taxon["title"],
          path: taxon["base_path"],
          tracking_category: "breadcrumbClicked",
          tracking_action: "superBreadcrumb",
          tracking_label: content_item["base_path"],
          tracking_dimension_enabled: false,
        }
      end

    private

      def preferred_taxon
        if preferred_priority_taxon
          priority_taxons.find { |t| t["content_id"] == preferred_priority_taxon }
        end
      end

      def priority_taxons
        return [] unless content_item["links"].is_a?(Hash)

        taxons = content_item.dig("links", "taxons")
        taxon_tree(taxons).select do |taxon|
          priority_taxon?(taxon)
        end
      end

      def taxon_tree(taxons)
        return [] if taxons.blank?

        taxons + taxons.flat_map { |taxon| taxon_tree(taxon.dig("links", "parent_taxons")) }
      end

      def priority_taxon?(taxon)
        PRIORITY_TAXONS.values.include?(taxon["content_id"])
      end

      def preferred_priority_taxon
        query_parameters["priority-taxon"] if query_parameters
      end
    end
  end
end
