Rails.application.routes.draw do
  devise_for :admins, controllers: { registration: 'admins/registration', sessions: 'admins/sessions' }
  devise_for :consumers, controllers: {omniauth_callbacks: 'consumers/omniauth_callbacks',
                                       registration: 'consumers/registration', sessions: 'consumers/sessions' }
  devise_for :employees, controllers: { registration: 'employees/registration', sessions: 'admins/sessions' }

  resources :admins, param: :username
  resources :consumers, param: :username
  resources :employees, param: :username

  get 'consumers/facebook/select_username'
  get 'consumers/facebook/connect_existing'

  root to: 'consumers#index'
end
