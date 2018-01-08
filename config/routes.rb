# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users, shallow: true, except: :index do
    resources :posts, except: :index do
      resources :comments, except: :show
    end

    resources :articles, except: :index do
      resources :comments
    end
  end

  resources :articles, only: :index

  resources :categories do
    resources :posts, only: :index
  end

  root 'posts#index'
end
