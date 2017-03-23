Rails.application.routes.draw do
  devise_for :admins, controllers: { registration: 'admins/registration', sessions: 'admins/sessions' }
  devise_for :consumers, controllers: { :omniauth_callbacks => 'consumers/omniauth_callbacks',
                                        registration: 'consumers/registration', sessions: 'consumers/sessions' }
  devise_for :employees, controllers: { registration: 'employees/registration', sessions: 'admins/sessions' }

  resources :admin
  resources :consumers
  resources :employees
end
