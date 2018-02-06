Rails.application.routes.draw do
  # Concerns

  # Searchable
  concern :searchable do
    get :search, on: :collection
  end

  # Votable
  concern :votable do
    member do
      get :down
      get :down_votes
      post :up
    end
  end

  # Routes

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
  resources :enterprises, param: :name, except: [:index] do
    get 'products', on: :member
  end

  # Product
  resources :products, except: [:index], concerns: :searchable do
    delete 'restore', on: :member

    # Advice thread
    resources :advice_threads, shallow: true, except: [:destroy], concerns: %i[searchable votable] do
      post :follow, on: :member

      # Advice comment
      resources :comments, shallow: true, except: %i[index destroy], concerns: :votable
    end

    # Problem thread
    resources :problem_threads, shallow: true, except: [:destroy], concerns: %i[searchable votable] do
      post :follow, on: :member

      # Problem comment
      resources :comments, shallow: true, except: %i[index destroy], concerns: :votable do
        post :mark, on: :member
      end
    end
  end

  # Relationship
  resources :relationships, only: %i[create destroy]

  # Votes
  resources :up_votes, only: %i[destroy]
  resources :down_votes, only: %i[create destroy]

  # Static pages
  get 'user_static_page/home'
  get 'user_static_page/help'

  # Root pages
  get '/welcome/enterprise', as: :admin_root
  get '/welcome/consumer', as: :consumer_root
  get '/welcome/enterprise', as: :employee_root
  root 'welcome#index'

  # TODO

  get 'consumer_static_pages/home'

  get 'consumer_static_pages/help'
end
