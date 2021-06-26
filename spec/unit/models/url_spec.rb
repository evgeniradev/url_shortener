# frozen_string_literal: true

require 'rails_helper'

describe Url do
  subject(:model) { described_class }

  let(:user) { create(:user) }
  let!(:url) { create(:url) }

  context 'when public methods' do
    it '#concurrent_increment! - when url is persisted' do
      threads = []
      10.times { threads << url.concurrent_increment! }
      threads.each(&:join)
      expect(url.reload.visits).to eq(10)
    end

    it '#concurrent_increment! - when url is not persisted' do
      message = 'Record must be persisted'
      expect { build(:url).concurrent_increment! }.to(
        raise_error(RuntimeError, message)
      )
    end

    it '#short_url - generates a short url' do
      url.update!(slug: 'test')
      expect(url.short_url).to eq('http://localhost:3333/test')
    end
  end

  context 'when validations' do
    it 'cannot create a url without a valid protocol' do
      message = 'Validation failed: Url requires a valid protocol'
      new_url = build(:url, url: 'shortener.url')
      expect { new_url.save! }.to(
        raise_error(ActiveRecord::RecordInvalid, message)
      )
    end

    it 'cannot create a url without a unique slug for user' do
      message = 'Validation failed: Slug has already been taken'
      expect { url.dup.update!(url: FFaker::Internet.uri('https')) }.to(
        raise_error(ActiveRecord::RecordInvalid, message)
      )
    end

    it 'can create a url if slug is not unique but user is different' do
      new_url = build(:url, user: create(:user))
      expect(new_url.save!).to be(true)
    end
  end

  context 'when scopes' do
    it '#for_user' do
      create(:url, user: create(:user))
      create_list(:url, 2, user: user)

      expect(model.for_user(user).count).to eq(2)
    end
  end
end
