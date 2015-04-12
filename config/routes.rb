Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  namespace :admin do
    resources :carbon_sources, only: [:index, :create, :new]
  end
end
