Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  namespace :admin do
    resources :carbon_sources, except: [:show, :destroy]
    resources :use_reasons, except: [:show, :destroy]
  end

  resources :carbon_sources, only: [:index, :show]

  resources :usages
end
