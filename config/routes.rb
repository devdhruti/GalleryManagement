Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root 'homes#index'
  resources :photos
  resources :albums
  
  namespace :api do
    namespace :v1 do
      
      resources :photos
      resources :albums

      devise_scope :user do
        get "/users" , to: "users#index"
        post "/users/sign_up", to: "registrations#create"
        post "/users/sign_in", to: "sessions#create"
        delete "/logout", to: "sessions#destroy"
        post "/confirm_email", to: "confirmations#confirm_email"
      end

      # routing error path
      match '*path', to: 'base#routing_error', via: %i[get post put patch delete]
      root to: 'base#routing_error'

    end
  end
end
