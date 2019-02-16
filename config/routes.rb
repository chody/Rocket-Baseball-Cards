# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cards
  devise_for :users
  resources :users, except: %i[new create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'
end
