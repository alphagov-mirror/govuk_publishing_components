require "rails_helper"

describe 'Component examples with accessibility criteria' do
  it 'shows the accessibility acceptance criteria as HTML' do
    visit '/component-guide/test-component'

    within ".component-accessibility-criteria" do
      expect(page).to have_selector('h2', text: 'Accessibility acceptance criteria')
      expect(page).to have_content('This is some criteria in a list')
    end
  end

  it 'shows shared accessibility criteria' do
    visit '/component-guide/test-component-with-shared-accessibility-criteria'

    within '.component-accessibility-criteria' do
      expect(page).to have_content("indicate when they have focus")
    end
  end

  it 'shows shared accessibility criteria when no other accessibility criteria are included' do
    visit '/component-guide/test-component-with-shared-accessibility-criteria-only'

    within '.component-accessibility-criteria' do
      expect(page).to have_content("indicate when they have focus")
    end
  end
end
