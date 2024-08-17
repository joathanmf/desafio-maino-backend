# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  root 'reports#index'

  get 'uploads', to: 'uploads#index'
  post 'uploads', to: 'uploads#create'

  resources :reports, only: %i[index show]

  patch 'change_locale', to: 'application#change_locale'

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
end
