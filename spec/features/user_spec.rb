# frozen_string_literal: true

require 'rails_helper'

describe 'Urls', type: :feature do
  it 'user can register' do
    when_user_visits_site
    when_user_goes_to_sign_up_page
    when_user_fill_in_form
    when_user_submits_sign_up_form
    then_user_has_been_created
    then_user_is_logged_in
  end

  it 'user can login and logout' do
    given_that_user_is_logged_out
    when_user_visits_site
    then_user_is_logged_out
    when_user_fills_in_login_form
    when_user_submits_login_form
    then_user_is_logged_in
  end

  private

  def when_user_fills_in_login_form
    fill_in :user_email, with: 'user@shortener.url'
    fill_in :user_password, with: 'password'
  end

  def given_that_user_is_logged_out
    when_user_visits_site
    when_user_goes_to_sign_up_page
    when_user_fill_in_form
    when_user_submits_sign_up_form
    when_user_logs_out
  end

  def when_user_visits_site
    visit root_path
  end

  def when_user_goes_to_sign_up_page
    click_link 'Sign up'
  end

  def when_user_fill_in_form
    fill_in :user_email, with: 'user@shortener.url'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
  end

  def when_user_submits_login_form
    click_button 'Log in'
  end

  def when_user_submits_sign_up_form
    click_button 'Sign up'
  end

  def then_user_has_been_created
    expect(User.find_by!(email: 'user@shortener.url')).to be_present
  end

  def when_user_logs_out
    click_link 'Logout'
  end

  def then_user_is_logged_in
    expect(page).to have_text('Logout')
  end

  def then_user_is_logged_out
    expect(page).to have_text('Log in')
  end
end
