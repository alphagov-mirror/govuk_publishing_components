require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'govuk_test'

GovukTest.configure(chrome_options: { w3c: true })
Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: { browser: 'ALL' })

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Helpers::Components, type: :view
end
