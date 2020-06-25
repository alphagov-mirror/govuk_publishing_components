require "rails_helper"

describe "Print link", type: :view do
  def component_name
    "print_link"
  end

  it "renders with default text no data is given" do
    render_component({})

    assert_select ".gem-c-print-link"
    assert_select(
      "button.gem-c-print-link__button",
      text: "Print this page",
    )
  end

  it "renders with alternative text when given" do
    render_component({
      text: "Print this manual",
    })

    assert_select ".gem-c-print-link"
    assert_select(
      "button.gem-c-print-link__button",
      text: "Print this manual",
    )
  end

  it "renders with alternative href as an anchor link" do
    render_component({
      href: "/print",
    })

    assert_select ".gem-c-print-link"
    assert_select(
      'a.gem-c-print-link__link[href="/print"]',
      text: "Print this page",
    )
  end
end
