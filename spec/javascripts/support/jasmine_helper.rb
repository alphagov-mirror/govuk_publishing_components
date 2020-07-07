require "jasmine/runners/selenium"
require "webdrivers/chromedriver"

Jasmine.configure do |config|
  config.runner = lambda { |formatter, jasmine_server_url|
    options = Selenium::WebDriver::Chrome::Options.new
    options.headless!
    options.add_argument("--no-sandbox")

    webdriver = Selenium::WebDriver.for(:chrome, options: options)
    Jasmine::Runners::Selenium.new(formatter, jasmine_server_url, webdriver, 50)
  }
end
