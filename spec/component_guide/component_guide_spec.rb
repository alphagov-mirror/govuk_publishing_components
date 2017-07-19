require "spec_helper"

describe 'Component guide' do
  it 'loads a component guide' do
    visit '/component-guide'
    expect(page).to have_title 'GOV.UK Component Guide'
  end

  it 'loads a component from the dummy app' do
    visit '/component-guide'
    expect(body).to include('A test component for the dummy app')
    expect(page).to have_selector('a[href="/component-guide/test-component"]', text: 'Test component')
  end

  it 'creates a page for the component' do
    visit '/component-guide/test-component'
    expect(body).to include('A test component for the dummy app')
  end

  it 'illustrates how to use the component' do
    visit '/component-guide/test-component'

    expect(body).to include('How to call this component')
    expect(body).to include('render \'components/test-component\'')
  end

  it 'includes the component partial' do
    visit '/component-guide/test-component'

    expect(body).to include('How it looks')
    within '.component-guide-preview' do
      expect(page).to have_selector('.some-test-component')
      expect(page).to have_selector('h1.something-inside-test-component', text: 'Test component heading')
    end
  end
end
