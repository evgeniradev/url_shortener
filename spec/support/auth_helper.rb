# frozen_string_literal: true

module AuthHelper
  def logged_in_as(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :controller
end
