Rails.application.routes.draw do
  devise_for :admins, path_prefix: 'auth', controllers: { passwords: 'admins/passwords',
                                                          sessions: 'admins/sessions',
                                                          unlocks: 'admins/unlocks' }

  devise_for :consumers, path_prefix: 'auth',
                         controllers: { omniauth_callbacks: 'consumers/omniauth_callbacks',
                                        passwords: 'consumers/passwords',
                                        registrations: 'consumers/registrations',
                                        sessions: 'consumers/sessions',
                                        unlocks: 'consumers/unlocks' }

  devise_for :employees, path_prefix: 'auth', controllers: { passwords: 'employees/passwords',
                                                             sessions: 'employees/sessions',
                                                             unlocks: 'employees/unlocks' }

  delete '/admins/lock/:username', to: 'admins#lock', as: 'admin_lock'
  post 'admins/unlock/:username', to: 'admins#unlock', as: 'admin_manual_unlock'


  resources :admins, param: :username
  resources :consumers, param: :username
  resources :employees, param: :username

  resources :enterprises, param: :name

  post 'auth/consumers/facebook/connect_existing'
  delete 'auth/consumers/facebook/disconnect'
  post 'auth/consumers/facebook/select_username'

  get '/welcome/enterprise', as: :admin_root
  get '/welcome/consumer', as: :consumer_root
  get '/welcome/enterprise', as: :employee_root

  root to: 'welcome#index'
end
