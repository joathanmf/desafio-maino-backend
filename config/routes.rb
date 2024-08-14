# frozen_string_literal: true

Rails.application.routes.draw do
  get 'uploads', to: 'uploads#index'
  post 'uploads', to: 'uploads#create'

  root 'home#index'

  devise_for :users
  get 'up' => 'rails/health#show', as: :rails_health_check
end
