# frozen_string_literal: true

require 'rails_helper'

describe 'Urls', type: :feature do
  let(:user) { create(:user) }
  let(:url) { create(:url, url: new_user_registration_url, user: user) }
  let(:another_url) { create(:url) }

  it 'user can generate a short url' do
    given_that_slug_generator_is_mocked
    given_that_user_is_logged_in
    when_user_visits_site
    when_user_fills_in_and_submits_the_form
    then_user_can_see_the_generated_short_url
    then_url_record_has_been_created
    then_url_visits_are_set_to(0)
    then_expect_url_record_to_be_assigned_to_the_user
    then_expect_only_one_url_record_to_exist
  end

  it 'user is redirected to long url when visiting short url' do
    given_that_url_record_exists
    given_single_url_record_exists
    given_that_visits_are_set_to(0)
    when_user_visits_the_short_url
    then_user_is_successfully_redirected_to_original_url
    then_url_visits_are_set_to(1)
    when_user_loggs_in
    when_user_visits_site
    then_user_can_see_the_updated_visits_counts
  end

  it 'user can only see their own url records' do
    given_that_url_record_exists
    given_that_another_url_record_exists
    given_that_user_is_logged_in
    when_user_visits_site
    then_user_cannot_see_the_url_record_that_is_not_theirs
  end

  it 'user cannot generate more than one url record with a given url' do
    given_that_slug_generator_is_mocked
    given_that_user_is_logged_in
    when_user_visits_site
    2.times { when_user_fills_in_and_submits_the_form }
    then_expect_only_one_url_record_to_exist
    then_expect_to_only_see_one_record_in_the_html_table
  end

  private

  def then_expect_to_only_see_one_record_in_the_html_table
    within '#urls-datatable tbody' do
      expect(page).not_to have_css('tr:nth-child(2)')
    end
  end

  def then_user_cannot_see_the_url_record_that_is_not_theirs
    within '#urls-datatable' do
      expect(page).not_to have_text(another_url.url)
    end
  end

  def then_expect_url_record_to_be_assigned_to_the_user
    expect(Url.first.user).to eq(user)
  end

  def then_expect_only_one_url_record_to_exist
    expect(Url.count).to be(1)
  end

  def then_user_is_successfully_redirected_to_original_url
    expect(url.url).to include(current_path)
  end

  def given_that_url_record_exists
    url
  end

  def given_that_another_url_record_exists
    another_url
  end

  def given_that_slug_generator_is_mocked
    allow(SlugGeneratorService).to receive(:call).and_return('test_slug')
  end

  def when_user_fills_in_and_submits_the_form
    fill_in :url_url, with: 'http://shortener.url'
    accept_alert do
      click_button 'Generate'
    end
  end

  def then_user_can_see_the_generated_short_url
    within '#urls-datatable' do
      expect(page).to have_text('http://shortener.url')
      expect(page).to have_text('http://localhost:3333/test_slug')
      expect(page).to have_text('0')
    end
  end

  def then_user_can_see_the_updated_visits_counts
    within '#urls-datatable tbody td:last-child' do
      expect(page).to have_text('1')
    end
  end

  def then_url_record_has_been_created
    expect(Url.first).to be_present
  end

  def then_url_visits_are_set_to(amount)
    expect(Url.first.visits).to be(amount)
  end

  def given_that_user_is_logged_in
    login_as(user)
  end

  def when_user_visits_site
    visit root_path
  end

  def when_user_visits_the_short_url
    visit url_path(url.slug)
  end

  alias_method :given_that_visits_are_set_to, :then_url_visits_are_set_to
  alias_method :when_user_loggs_in, :given_that_user_is_logged_in
  alias_method :given_single_url_record_exists, :then_expect_only_one_url_record_to_exist
end
