# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'mailbox/inbox', to: 'mailbox#inbox'
  get 'mailbox/sentbox', to: 'mailbox#sentbox'
  get 'mailbox/trash', to: 'mailbox#trash'

  resources :articles, only: :index

  resources :categories, except: %i[index show] do
    resources :posts, only: :index
  end

  resources :sports, only: %i[show destroy index] do
    resource :follows, only: %i[create destroy]
    get '/followers', to: 'follows#index'

    resources :invitation_posts, shallow: true do
      resources :comments, except: %i[index show]
    end
  end

  resources :phone_verifications, only: %i[new create] do
    collection do
      get 'challenge'
      post 'verify'
      get 'success'
    end
  end

  resources :users, shallow: true, except: %i[index create new] do
    resources :articles, except: :index do
      resources :comments, except: %i[index show]
    end

    resources :conversations do
      resources :messages
      post '/untrash', to: 'conversations#untrash'
    end


    resource :follows, only: %i[create destroy]
    get '/followers', to: 'follows#index'

    resources :posts, except: :index do
      resources :comments, except: %i[index show]
    end
  end

  root 'articles#index'
end
