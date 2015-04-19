Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "usages#index", as: :authenticated_root
  end

  unauthenticated do
    root to: 'homes#index'
  end

  namespace :admin do
    resources :carbon_sources, except: [:show, :destroy]
    resources :use_reasons, except: [:show, :destroy]
  end

  resources :carbon_sources, only: [:index, :show]

  resources :usages
end
