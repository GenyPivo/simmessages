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
  resources :messages, only: [:index, :show, :destroy]
end
