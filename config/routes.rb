Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "letters#index"
  get '/search_letters', to: 'letters#search_letters'
  devise_for :users
  resources :letters
  resources :users
end
