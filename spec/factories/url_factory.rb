# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    url { FFaker::Internet.uri('https') }
    slug { SlugGeneratorService.call }
    user { create(:user) }
  end
end
