Rails.application.routes.draw do
  get 'users/index'

  devise_for :user, controllers: {
        registrations: 'users/registrations'
      }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, only: :index
  resources :users do
    resources :messages, only: [:new, :create]
  end

  resources :messages, only: [:index, :destroy] do
    collection do
      get 'conversation/:id', action: :show
    end
  end

  namespace :admin do
    resources :users
  end

  root 'users#index'
  mount ActionCable.server => '/cable'
end
