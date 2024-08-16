# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'uploads', to: 'uploads#index'
  post 'uploads', to: 'uploads#create'

  resources :reports, only: %i[index show]

  get 'up' => 'rails/health#show', as: :rails_health_check
end
