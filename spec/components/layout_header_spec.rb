require "rails_helper"

describe "Layout header", type: :view do
  def component_name
    "layout_header"
  end

  it "renders the header" do
    render_component(environment: "staging")

    assert_select ".govuk-header"
  end

  it "renders the header without environment tag if no environment is given" do
    render_component({})

    assert_select ".gem-c-environment-tag", 0
  end

  it "renders the header with environment tag and environment modifier class" do
    render_component(environment: "staging")

    assert_select ".govuk-header.gem-c-layout-header--staging"
    assert_select ".gem-c-environment-tag", text: "staging"
  end

  it "renders the product name" do
    render_component(environment: "staging", product_name: "Product name")

    assert_select ".govuk-header__product-name", text: "Product name"
    assert_select ".gem-c-environment-tag", text: "staging"
  end

  it "renders at a constrained width by default" do
    render_component(environment: "staging", product_name: "Product name")

    assert_select ".govuk-width-container"
  end

  it "renders at full width when requested to" do
    render_component(environment: "staging", product_name: "Product name", full_width: true)

    assert_select ".govuk-header__container--full-width"
  end

  it "renders the product name if given" do
    render_component(product_name: "Product name")

    assert_select ".govuk-header__product-name", text: "Product name"
  end

  it "renders the header with navigation items" do
    navigation_items = [
      { text: "Foo", href: "/foo", active: true },
      { text: "Bar", href: "/bar" },
      { text: "Hello", href: "/hello", show_only_in_collapsed_menu: true },
    ]

    render_component(environment: "staging", navigation_items: navigation_items)

    assert_select ".govuk-header__navigation-item.govuk-header__navigation-item--active", text: "Foo"
    assert_select ".govuk-header__navigation-item", text: "Bar"
    assert_select ".govuk-header__navigation-item.govuk-header__navigation-item--collapsed-menu-only", text: "Hello"
    assert_select ".gem-c-header__nav[aria-label='Top level']"
  end

  it "renders the header navigation items with custom aria-label when navigation_aria_label is specified" do
    navigation_items = [
      { text: "Foo", href: "/foo", active: true },
      { text: "Bar", href: "/bar" },
      { text: "Hello", href: "/hello", show_only_in_collapsed_menu: true },
    ]

    render_component(environment: "staging", navigation_items: navigation_items, navigation_aria_label: "My fancy label")

    assert_select ".gem-c-header__nav[aria-label='My fancy label']"
  end

  it "renders the header without the bottom border" do
    render_component(remove_bottom_border: true, environment: "public")

    assert_select ".gem-c-layout-header--no-bottom-border"
  end

  it "renders without a search bar by default" do
    render_component({ environment: "" })

    assert_select ".gem-c-layout-header .gem-c-search", false
  end

  it "renders a search bar" do
    render_component(environment: "public", search: true)

    assert_select ".gem-c-layout-header .gem-c-search"
  end

  it "renders the search bar on the left when requested" do
    render_component(environment: "public", search: true, search_left: true)

    assert_select ".gem-c-layout-header--search-left"
  end
end
