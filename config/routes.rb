Rails.application.routes.draw do
  devise_for :admins, controllers: {sessions: 'admins/sessions'}
  devise_for :sellers, controllers: {sessions: 'sellers/sessions'}
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  root 'tops#show'
  resource :top, only:[:show]
  namespace :admins do
    resources :users, only: %i[index show edit update destroy]
    resources :sellers, only: %i[index new create]
    resources :products
  end
  namespace :users do
    resources :products, only: %i[index show] do
      resources :cart_products, only: %i[new create]
    end
    resources :cart_products, only: %i[index destroy]
    resources :ordered_products, only: %i[create]
    resources :orders, only: %i[index new create show]
  end
end
