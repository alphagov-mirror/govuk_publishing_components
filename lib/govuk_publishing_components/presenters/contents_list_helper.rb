require 'action_view'

module GovukPublishingComponents
  module Presenters
    class ContentsListHelper
      include ActionView::Helpers::SanitizeHelper

      attr_reader :classes, :contents

      def initialize(options)
        @contents = options[:contents] || []
        @nested = !!@contents.find { |c| c[:items] && c[:items].any? }
        @format_numbers = options[:format_numbers]
        @font_size = options[:font_size]

        @classes = %w(gem-c-contents-list)
        @classes << " gem-c-contents-list--no-underline" unless options[:underline_links]
        @classes << " gem-c-contents-list--font-size-#{@font_size}" if [24, 19].include? @font_size
      end

      def list_item_classes(list_item, nested)
        list_item_classes = "gem-c-contents-list__list-item"
        list_item_classes << " gem-c-contents-list__list-item--#{parent_modifier}" unless nested
        list_item_classes << " gem-c-contents-list__list-item--dashed" if nested
        list_item_classes << " gem-c-contents-list__list-item--active" if list_item[:active]

        list_item_classes
      end

      def wrap_numbers_with_spans(content_item_link)
        content_item_text = strip_tags(content_item_link) #just the text of the link

        # Must start with a number
        # Number must be between 1 and 999 (ie not 2014)
        # Must be followed by a space
        # May contain a period `1.`
        # May be a decimal `1.2`
        number = /^\d{1,3}(\.?|\.\d{1,2})(?=\s)/.match(content_item_text)

        if number
          words = content_item_text.sub(number.to_s, '').strip #remove the number from the text
          content_item_link.sub(content_item_text, "<span class=\"gem-c-contents-list__number\">#{number} </span><span class=\"gem-c-contents-list__numbered-text\">#{words}</span>").squish.html_safe
        else
          content_item_link
        end
      end

    private

      def parent_modifier
        if @nested
          'parent'
        elsif @format_numbers
          'numbered'
        else
          'dashed'
        end
      end
    end
  end
end
