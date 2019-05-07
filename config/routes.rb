# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get 'contact_us', to: 'messages#contact_us', as: 'contact_us'
    post 'contact_us', to: 'messages#create'
    resources :news
    devise_for :users
    root to: 'news#index'
    resources :categories
    resources :events
  end
end
