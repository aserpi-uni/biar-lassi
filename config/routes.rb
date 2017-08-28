Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :consumers, controllers: { omniauth_callbacks: 'consumers/omniauth_callbacks',
                                        registrations: 'consumers/registrations', sessions: 'consumers/sessions' }
  devise_for :employees, controllers: { sessions: 'admins/sessions' }

  resources :admins, param: :username
  resources :consumers, param: :username
  resources :employees, param: :username

  get 'consumers/facebook/connect_existing'
  get 'consumers/facebook/disconnect'
  get 'consumers/facebook/select_username'

  get '/welcome/enterprise', as: :admin_root
  get '/welcome/consumer', as: :consumer_root
  get '/welcome/enterprise', as: :employee_root

  root to: 'welcome#index'
end
