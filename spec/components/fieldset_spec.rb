require 'rails_helper'

describe "Fieldset", type: :view do
  def component_name
    "fieldset"
  end

  it "fails to render when no data is given" do
    assert_raises do
      render_component({})
    end
  end

  it "renders a fieldset correctly" do
    render_component(
      legend_text: 'Do you have a passport?',
      text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vel ad neque, maxime est ea laudantium totam fuga!'
    )

    assert_select ".govuk-fieldset__legend", text: 'Do you have a passport?'
    assert_select ".gem-c-fieldset", text: /Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vel ad neque, maxime est ea laudantium totam fuga!/
  end

  it "renders a fieldset with a custom size legend" do
    render_component(
      legend_text: 'Do you have a passport?',
      heading_size: 'xl',
      text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vel ad neque, maxime est ea laudantium totam fuga!'
    )

    assert_select ".govuk-fieldset__legend.govuk-fieldset__legend--xl"
  end
end
