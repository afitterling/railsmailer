require_relative "../webhooks/github"

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :devices, only: :create
  resources :log_data, only: [:index, :create, :show]
  resources :mailers, only: :create
  post '/mailers/:uid/deliver', to: 'mailers#deliver'
  resources :sites, only: :create
  post '/sites/:uid/deliver', to: 'sites#deliver', as: :deliver_site_email

  mount Github.new => "/webhooks/github"
end
