# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get 'contact_us', to: 'messages#contact_us', as: 'contact_us'
    post 'contact_us', to: 'messages#create'
    resources :news do
      resources :comments
    end
    resources :comments do
      resources :comments
    end
    devise_for :users, skip: :omniauth_callbacks, controllers:
      {
        registrations: 'devise_overrides/registrations'
      }
    resources :users
    root to: 'news#index'
    resources :categories
    resources :events
    resources :users do
      get :update_password
      patch :update_password
      get :edit_password
    end

    get :approve, to: 'email_change_requests#approve'
    resources :email_change_requests
  end

  devise_for :users, only: :omniauth_callbacks, controllers:
    {
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
end
