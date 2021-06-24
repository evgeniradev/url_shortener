# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'urls#index'

  resources :urls, only: %i[index create show destroy]
end
