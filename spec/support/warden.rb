# frozen_string_literal: true

RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
  Warden.test_mode!
end
