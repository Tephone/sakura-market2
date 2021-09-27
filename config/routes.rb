Rails.application.routes.draw do
  devise_for :admins, controllers: {sessions: 'admins/sessions'}
  devise_for :sellers, controllers: {sessions: 'sellers/sessions'}
  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  root 'tops#show'
  resource :top, only:[:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
