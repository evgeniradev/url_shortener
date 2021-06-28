# frozen_string_literal: true

RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  config.after type: :feature do
    Capybara.reset_sessions!
    Warden.test_reset!
  end
end
