Rails.application.routes.draw do
  require 'sidekiq/web'
  # or require 'sidekiq/pro/web'
  # or require 'sidekiq-ent/web'

  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
  # get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker

  get 'styleguide', to: 'application#styleguide', as: 'styleguide'

  namespace :admin do
    resources :admins
    resources :users
    resources :consents
  end

  devise_for :admins, skip: [:registrations]
  as :admin do
    get 'admins/edit', to: 'devise/registrations#edit', as: 'edit_admin_registration'
    put 'admins', to: 'devise/registrations#update', as: 'admin_registration'
    get 'admin', to: 'admin/admins#index', as: 'admin_root'
  end

  devise_for :users, controllers:
    {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      invitations: 'users/invitations'
    }

  authenticate :user do
    resources :budgets do
      member do
        patch :archive
      end
    end
    resources :goals do
      resources :transfers
      member do
        patch :cancel
        patch :update_amount
      end
    end
    resources :groups do
      resources :categories
      resources :wallets
      resources :tags
      resources :members do
        member do
          delete :remove
        end
      end
    end
    resources :wallets do
      resources :transfers
      resources :transactions do
        member do
          post :add_tag
          get :tags
        end
      end
      member do
        get :new_info
        get :new_bank_choice
        get :account_selection
        post :exchange_public_token
        post :disconnect_wallet
        post :select_account
      end
    end
  end

  resources :consents, param: :kind, only: [:show, :create] do
    collection do
      get 'missing'
      get 'accept_cookies'
    end
  end

  get 'more', to: 'general_pages#more_menu'
  get 'template', to: 'general_pages#template'
  root 'general_pages#index'
end
