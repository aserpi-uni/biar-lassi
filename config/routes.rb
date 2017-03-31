Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: 'admins/registrations', sessions: 'admins/sessions' }
  devise_for :consumers, controllers: {omniauth_callbacks: 'consumers/omniauth_callbacks',
                                       registrations: 'consumers/registrations', sessions: 'consumers/sessions' }
  devise_for :employees, controllers: { registrations: 'employees/registrations', sessions: 'admins/sessions' }

  resources :admins, param: :username
  resources :consumers, param: :username
  resources :employees, param: :username

  get 'consumers/facebook/select_username'
  get 'consumers/facebook/connect_existing'
  get 'consumers/facebook/disconnect'

  root to: 'consumers#index'
end
