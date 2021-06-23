# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __dir__)

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
end
