# frozen_string_literal: true

require 'rails_helper'

describe SlugGeneratorService do
  subject(:slug_generator_service) { described_class }

  it 'generates a slug with 11 characters' do
    expect(slug_generator_service.call.length).to eq(11)
  end
end
