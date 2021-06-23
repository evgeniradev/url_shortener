# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'user@shortener.url' }
    password { 'password' }
  end
end
