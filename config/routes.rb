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

  mount Github.new => "/webhooks/github"
end
