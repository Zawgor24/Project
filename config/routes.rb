# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :users, shallow: true, except: %i[index create new] do
    resources :posts, except: :index do
      resources :comments, except: %i[index show]
    end

    resources :articles, except: :index do
      resources :comments, except: %i[index show]
    end
  end

  resources :sports, only: %i[show destroy index] do
    resource :follows, only: %i[create destroy]
    get '/followers', to: 'follows#followers'

    resources :invitation_posts, shallow: true do
      resources :comments, except: %i[index show]
    end
  end

  resources :articles, only: :index

  resources :categories do
    resources :posts, only: :index
  end

  root 'articles#index'
end
