Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root 'welcome#index'

  resources :events, only: [:create, :update, :destroy, :index] do
    collection do
      get :data_table
    end

    member do
      get :data_table
    end
  end
  resources :vacation_requests, only: [:create, :update, :destroy]

  namespace :admin do
    get '/' => 'dashboard#index', as: :dashboard

    resources :projects, except: [:show, :new, :update] do
      collection do
        post :add_user
        patch :remove_user
      end
    end

    resources :users, except: [:new, :create] do
      collection do
        post :add_rate
      end

      member do
        patch :remove_project
        patch :set_limit
        post :add_project
        post :accept_vacation
        post :decline_vacation
        get :event_table, controller: :events
      end
    end

    resources :reports, only: [:index]
  end
end
