Rails.application.routes.draw do
  # Admin
  devise_for :admins, path_prefix: 'auth', controllers: { passwords: 'admins/passwords',
                                                          sessions: 'admins/sessions',
                                                          unlocks: 'admins/unlocks' }
  resources :admins, param: :username
  delete 'admins/lock/:username', to: 'admins#lock', as: 'admin_lock'
  post 'admins/unlock/:username', to: 'admins#unlock', as: 'admin_manual_unlock'

  # Consumer
  devise_for :consumers, path_prefix: 'auth',
                         controllers: { omniauth_callbacks: 'consumers/omniauth_callbacks',
                                        passwords: 'consumers/passwords',
                                        registrations: 'consumers/registrations',
                                        sessions: 'consumers/sessions',
                                        unlocks: 'consumers/unlocks' }
  resources :consumers, param: :username do
    get :following, on: :member
  end
  post 'auth/consumers/facebook/connect_existing'
  delete 'auth/consumers/facebook/disconnect'
  post 'auth/consumers/facebook/select_username'

  # Employee
  resources :employees, param: :username
  devise_for :employees, path_prefix: 'auth', controllers: { passwords: 'employees/passwords',
                                                             sessions: 'employees/sessions',
                                                             unlocks: 'employees/unlocks' }
  delete 'employees/lock/:username', to: 'employees#lock', as: 'employee_lock'
  post 'employees/unlock/:username', to: 'employees#unlock', as: 'employee_manual_unlock'

  # Enterprise
  resources :enterprises, param: :name do
    get 'products', on: :member
  end

  # Post
  resources :posts, only: %i[create destroy]

  # Product
  resources :products, except: [:index] do
    delete 'restore', on: :member
    get 'search', on: :collection

    resources :problem_threads do
      member do
        get :followers
      end
      resources :comments
    end
  end

  # Relationship
  resources :relationships, only: [:create, :destroy]

  # Static pages
  get 'user_static_page/home'
  get 'user_static_page/help'

  # Root pages
  get '/welcome/enterprise', as: :admin_root
  get '/welcome/consumer', as: :consumer_root
  get '/welcome/enterprise', as: :employee_root
  root 'welcome#index'
end
