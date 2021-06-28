# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __dir__)
require 'rspec/rails'

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
end
