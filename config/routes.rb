Rails.application.routes.draw do
  ### Concerns

  # Lockable
  concern :lockable do
    member do
      delete :lock
      post :manual_unlock
    end
  end

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

  ### Routes

  ## Dynamic

  # Admin
  devise_for :admins, path_prefix: 'auth', controllers: { passwords: 'admins/passwords',
                                                          sessions: 'admins/sessions',
                                                          unlocks: 'admins/unlocks' }
  resources :admins, param: :username, except: [:index], concerns: :lockable

  # Consumer
  devise_for :consumers, path_prefix: 'auth',
                         controllers: { omniauth_callbacks: 'consumers/omniauth_callbacks',
                                        passwords: 'consumers/passwords',
                                        registrations: 'consumers/registrations',
                                        sessions: 'consumers/sessions',
                                        unlocks: 'consumers/unlocks' }
  resources :consumers, param: :username, except: %i[index new create] do
    get :following, on: :member
  end

  # Employee
  devise_for :employees, path_prefix: 'auth', controllers: { passwords: 'employees/passwords',
                                                             sessions: 'employees/sessions',
                                                             unlocks: 'employees/unlocks' }
  resources :employees, param: :username, except: [:index], concerns: :lockable

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

  # Votes
  resources :up_votes, only: %i[destroy]
  resources :down_votes, only: %i[create destroy]

  ## Root pages

  # Consumer
  authenticated :consumer do
    root 'user_static_pages#consumer', as: :consumer_root
  end

  # Employee
  authenticated :employee do
    root 'user_static_pages#employee', as: :employee_root
  end

  # General
  root 'welcome#index'

  ## Static

  get 'consumer_static_pages/help'
  post 'auth/consumers/facebook/connect_existing'
  post 'auth/consumers/facebook/select_username'
  delete 'auth/consumers/facebook/disconnect'
end
