# Our constraints around versioning.
require 'api_constraints'

Rails.application.routes.draw do
  get '', to: 'pages#index', as: 'home'
  get 'about', to: 'pages#about', as: 'about'
  get 'help', to: 'pages#help', as: 'help'

  devise_for :users, :path => 'api/users',
             :controllers => { sessions: 'sessions',
                               registrations: 'registrations' },
             :path_names => { :sign_in => 'login',
                              :sign_out => 'logout',
                              :sign_up => 'signup' }

  # viewable project mappings
  resources :projects #, :only => [:show] # , :new, :create
  resources :users

  post 'courses/create',      to: 'courses#create', as: 'course_create'
  get 'courses/new',          to: 'courses#new', as: 'course_new'
  post 'courses/:id/update',  to: 'courses#update', as: 'course_update'
  post 'courses/:id/delete',  to: 'courses#delete', as: 'course_delete'
  get 'courses/:id/edit',     to: 'courses#edit', as: 'course_edit'
  get 'courses/:id',          to: 'courses#show', as: 'course_show'
  get 'courses',              to: 'courses#index', as: 'course_index'

  # Redirect simple requets for the viewable app
  devise_scope :user do
    get 'login', to: 'sessions#new', as: :login
    get 'logout', to: 'sessions#destroy', as: :logout
    get 'signup', to: 'registrations#new', as: :signup
  end

  # NOTE: We should probably use a subdomain in the future, add:
  # constraints: { subdomain: 'api' }, path: '/'
  # Scoping is used so that there isn't a version in the URL
  namespace :api, defaults: { format: :json }  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # Tokens are an easier way to handle API auth.
      resources :users do
        # TODO: Restrict options here
        resources :projects
      end
      # TODO: Restrict options here to not duplicate the ones above.
      resources :projects
      # Comments eventually?
    end
  end

  get 'users/:id', to: 'users#profile', as: 'user_profile'
  
  # Shortcuts to the Snap! submodule
  # NOTE: the redirect needs a trailing / to load the JS properly.
  # TODO: Serving this way is probably not the best...
  get 'run', to: redirect('snap/')

end
