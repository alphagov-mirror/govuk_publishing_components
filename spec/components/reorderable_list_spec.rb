require "rails_helper"

describe "Reorderable list", type: :view do
  def component_name
    "reorderable_list"
  end

  def items
    [
      {
        id: "item-1",
        title: "Budget 2018",
        description: "PDF, 2.56MB, 48 pages",
      },
      {
        id: "item-2",
        title: "Budget 2018 (web)",
        description: "HTML attachment",
      },
      {
        id: "item-3",
        title: "Impact on households: distributional analysis to accompany Budget 2018",
        description: "PDF, 592KB, 48 pages",
      },
      {
        id: "item-3",
        title: "Table 2.1: Budget 2018 policy decisions",
        description: "MS Excel Spreadsheet, 248KB",
      },
      {
        id: "item-3",
        title: "Table 2.2: Measures announced at Autumn Budget 2017 or earlier that will take effect from November 2018 or later (£ million)",
        description: "MS Excel Spreadsheet, 248KB",
      },
    ]
  end

  it "renders a list of items" do
    render_component(items: items)

    assert_select ".gem-c-reorderable-list"
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border", 5
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border" do |elements|
      elements.each_with_index do |element, index|
        assert_select element, ".gem-c-reorderable-list__title", { text: items[index][:title] }
        assert_select element, ".gem-c-reorderable-list__description", { text: items[index][:description] }
        assert_select element, ".gem-c-reorderable-list__actions"
        assert_select element, ".gem-c-reorderable-list__actions .js-reorderable-list-up", { text: "Up" }
        assert_select element, ".gem-c-reorderable-list__actions .js-reorderable-list-down", { text: "Down" }
        assert_select element, ".gem-c-reorderable-list__actions input[name='ordering[#{items[index][:id]}]']"
        assert_select element, ".gem-c-reorderable-list__actions input[value='#{index + 1}']"
      end
    end
  end

  it "renders allows custom input names" do
    render_component(items: items, input_name: "attachments[ordering]")

    assert_select ".gem-c-reorderable-list"
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border" do |elements|
      elements.each_with_index do |element, index|
        assert_select element, ".gem-c-reorderable-list__actions input[name='attachments[ordering][#{items[index][:id]}]']"
      end
    end
  end

  it "renders a list of items as a numeric list" do
    render_component(items: items, numeric_list: true)

    assert_select ".gem-c-reorderable-list.gem-c-reorderable-list--numeric-list"
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border", 5
  end

  it "renders a list of items as a numeric list and bottom border" do
    render_component(items: items, numeric_list: true, border_bottom: true)

    assert_select ".gem-c-reorderable-list.gem-c-reorderable-list--numeric-list"
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border", false
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border-bottom", 5
  end

  it "renders a list of items with bottom border" do
    render_component(items: items, border_bottom: true)

    assert_select ".gem-c-reorderable-list"
    assert_select ".gem-c-reorderable-list.gem-c-reorderable-list--numeric-list", false
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border", false
    assert_select ".gem-c-reorderable-list__item.gem-c-reorderable-list__item--border-bottom", 5
  end
end
