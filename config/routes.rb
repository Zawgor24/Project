# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users, shallow: true, except: [:index] do
    resources :posts, except: [:index]
    resources :articles, except: [:index]
  end

  resources :posts, :articles, only: [:index]

  root 'posts#index'
end
