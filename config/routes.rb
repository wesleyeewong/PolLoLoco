# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :access_tokens, only: [:create]

  resources :plans, only: %i[create index]
  resources :progressions, only: %i[create index]
  resources :movements, only: [:index]

  get :current_day, to: "day_assignments#current_day"

  namespace :auth do
    resources :google, only: [:create]
  end

  post :testing, to: "testings#create"
end
