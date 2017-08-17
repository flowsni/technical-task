Rails.application.routes.draw do
  mount API => '/'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "letters#index"
  devise_for :users
  resources :letters do
    collection do
      get 'search_letters'
    end
  end

end
