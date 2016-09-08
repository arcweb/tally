Rails.application.routes.draw do
  devise_for :users, 
    controllers: { 
      omniauth_callbacks: "users/omniauth_callbacks" 
    }

  devise_scope :user do
    get 'users/auth/google_oauth2', to: 'devise/sessions#new', as: :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session

    authenticated do
      root to: 'users#show', as: 'authenticated'
    end
  end

  resources :users, only: [:show, :index, :update, :destroy] do
    delete 'vacation_days/:vacation_day_id', to: 'cancel_pto_time_requests#create', shallow: true, as: 'cancel_vacation_day', on: :member
  end
  
  resources :time_requests, only: [:create] do
    get 'pending', on: :collection
    get 'clear', on: :member
  end

  get 'pto_requests/:id/approve', to: 'pto_time_requests#approve', as: 'approve_pto_request'
  get 'pto_requests/:id/deny', to: 'pto_time_requests#deny', as: 'deny_pto_request'
  
  root to: 'static#home', as: :home
end
