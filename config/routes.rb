Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :sellers, controllers: { sessions: 'sellers/sessions' }
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  mount LetterOpenerWeb::Engine, at: '/inbox' if Rails.env.development?
  root 'tops#show'
  resource :top, only: [:show]
  namespace :admins do
    resources :users, only: %i[index show edit update destroy]
    resources :sellers
    resources :products
    resources :coupons
  end
  namespace :users do
    resource :mypage, only: [:show]
    resources :products, only: %i[index show] do
      resources :cart_products, only: %i[new create], module: :products
    end
    resources :cart_products, only: %i[index destroy]
    resources :ordered_products, only: %i[create]
    resources :orders, only: %i[index new create show]
    resources :diaries
    resources :user_coupons, only: %i[index new create]
    resources :order_cancels, only: [:update]
  end

  namespace :sellers do
    resources :products, only: %i[index new create show edit update]
    resources :orders, only: %i[index show edit update]
  end

  resources :diaries, only: %i[index show] do
    resources :comments, only: %i[create destroy], module: :diaries
    resources :likes, only: %i[create destroy], module: :diaries
  end
end
