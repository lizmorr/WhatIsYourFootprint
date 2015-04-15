Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  namespace :admin do
    resources :carbon_sources, only: [:index, :create, :new, :edit, :update]
  end

  resources :carbon_sources, only: [:index, :show]
end
