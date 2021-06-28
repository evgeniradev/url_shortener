# frozen_string_literal: true

require 'rails_helper'

describe UrlsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:url) do
    create(:url, url: new_user_registration_url(host: SEVER_HOST), user: user)
  end

  describe 'GET index' do
    it 'redirects with status 302 if user not logged in' do
      get :index
      expect(response.status).to be(302)
    end

    it 'returns status 200 if user logged in' do
      logged_in_as(user)
      get :index
      expect(response.status).to be(200)
    end

    it 'returns url records assigned to user as json' do
      create(:url, user: another_user)
      urls = [create(:url, user: user), create(:url, user: user)]
      serialized_urls = each_serializer(collection: urls, serializer: UrlSerializer)
      expectation = { 'data' => serialized_urls }

      logged_in_as(user)
      get :index, format: :json

      expect(JSON.parse(response.body)).to eq(expectation)
    end
  end

  describe 'GET show' do
    before do
      # Needed because Thread logs ActiveRecord::RecordNotFound.
      # This happens when one of the below specs sometimes finishes running
      # before the Thread instance in #concurrent_increment! does.
      # When the specs finish running, the url record is deleted, so the Thread
      # cannot find it and raises an error.
      Thread.report_on_exception = false
    end

    it 'broadcasts visit count to current_user' do
      allow(UrlChannel).to receive(:broadcast_to).and_return(true)
      get :show, params: { slug: url.slug }
      # sleep to let Thread finish
      sleep 1
      expect(UrlChannel).to have_received(:broadcast_to)
    end

    it 'increments url visits count' do
      get :show, params: { slug: url.slug }
      expect(url.reload.visits).to be(1)
      sleep 1
    end

    it 'returns status 302 when url record exists' do
      get :show, params: { slug: url.slug }
      expect(response.status).to be(302)
      sleep 1
    end

    it 'redirects to full url when url record exists' do
      get :show, params: { slug: url.slug }
      expect(response.body).to include(url.url)
      sleep 1
    end

    it 'returns status 400 when url record does not exists' do
      get :show, params: { slug: '' }
      expect(response.status).to be(400)
      sleep 1
    end
  end

  describe 'POST create' do
    it 'returns status 200' do
      success_case
      expect(response.status).to be(200)
    end

    it 'creates record successfully' do
      success_case
      expect(Url.find_by!(url: 'http://shorener.url')).to be_present
    end

    it 'auto-generates slug for url record' do
      slug = 'test_slug'
      allow(SlugGeneratorService).to receive(:call).and_return(slug)
      original_url = 'http://shorener.url'
      logged_in_as(user)
      post :create, params: { url: { url: original_url } }
      expect(Url.find_by!(url: original_url).slug).to eq(slug)
    end

    it 'returns status 400 when url record fails to create' do
      logged_in_as(user)
      post :create, params: { url: { url: '' } }
      expect(response.status).to be(400)
    end

    it 'redirects if user not logged in' do
      post :create, params: { url: { url: 'http://shorener.url' } }
      expect(response.status).to be(302)
    end

    def success_case
      logged_in_as(user)
      post :create, params: { url: { url: 'http://shorener.url' } }
    end
  end
end
