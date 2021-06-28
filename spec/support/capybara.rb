# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/apparition'
require 'capybara-screenshot/rspec'

DRIVER_NAME = :apparition_chrome
SERVER_PORT = 3333
SEVER_HOST = 'localhost'

# rubocop:disable Style/MutableConstant
APPARITION_OPTIONS = {
  headless: true,
  url_whitelist: ['localhost'],
  browser_options: {
    'no-sandbox' => nil,
    'disable-gpu' => nil,
    'disable-infobars' => nil,
    'start-maximized' => nil,
    'disable-web-security' => nil,
    'allow-running-insecure-content' => nil,
    'ignore-certificate-errors' => nil,
    'disable-features' => 'VizDisplayCompositor',
    'window-size' => '1920,3080',
    'enable-features' => 'NetworkService,NetworkServiceInProcess'
  }
}
# rubocop:enable Style/MutableConstant

Capybara.register_driver DRIVER_NAME do |app|
  Capybara::Apparition::Driver.new(app, APPARITION_OPTIONS)
end

Capybara::Screenshot.register_driver(DRIVER_NAME) do |driver, path|
  driver.save_screenshot(path, full: true)
end

Capybara.server_host = SEVER_HOST
Capybara.server_port = SERVER_PORT
Capybara.default_driver = DRIVER_NAME
Capybara.javascript_driver = DRIVER_NAME

Capybara::Screenshot.autosave_on_failure = true

RSpec.configure do |config|
  config.include Capybara::DSL, type: :request
end
