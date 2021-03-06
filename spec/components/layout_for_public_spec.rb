require "rails_helper"

describe "Layout for public", type: :view do
  def component_name
    "layout_for_public"
  end

  it "adds a default <title> tag" do
    render_component({})

    assert_select "title", visible: false, text: "GOV.UK - The best place to find government services and information"
  end

  it "adds a custom <title> tag" do
    render_component(title: "Custom GOV.UK Title")

    assert_select "title", visible: false, text: "Custom GOV.UK Title"
  end

  it "displays as a restricted width layout by default" do
    render_component({})

    assert_select "#wrapper.govuk-width-container"
  end

  it "can support full width layouts" do
    render_component(full_width: true)

    assert_select "#wrapper.govuk-width-container", false, "Should not apply govuk-width-container class when full width"
  end

  it "displays with search bar by default" do
    render_component({})

    assert_select ".gem-c-layout-for-public .gem-c-search"
  end

  it "can display without search bar" do
    render_component(show_search: false)

    assert_select ".gem-c-layout-for-public .gem-c-search", false
  end

  it "can omit the header" do
    render_component(omit_header: true)

    assert_select ".gem-c-layout-for-public .gem-c-layout-header", false
  end

  it "can add a emergency banner" do
    render_component({
      emergency_banner: "<div id='test-emergency-banner'>This is an emergency banner test</div>",
    })

    assert_select "#test-emergency-banner", text: "This is an emergency banner test"
  end

  it "can add a global bar" do
    render_component({
      global_bar: "<div id='test-global-banner'>This is a global bar test</div>",
    })

    assert_select "#test-global-banner", text: "This is a global bar test"
  end

  it "can add both an emergency banner and a global bar" do
    render_component({
      emergency_banner: "<div id='test-emergency-banner'>This is an emergency banner test</div>",
      global_bar: "<div id='test-global-banner'>This is a global bar test</div>",
    })

    assert_select "#test-emergency-banner", text: "This is an emergency banner test"
    assert_select "#test-global-banner", text: "This is a global bar test"
  end

  it "has a blue bar by default" do
    render_component({})

    assert_select ".gem-c-layout-for-public__blue-bar"
  end

  it "has no blue bar when using the full width layout" do
    render_component(full_width: true)

    assert_select ".gem-c-layout-for-public__blue-bar", false
  end
end
