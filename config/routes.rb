# Our constraints around versioning.
require 'api_constraints'

Rails.application.routes.draw do
  get '', to: 'pages#index', as: 'home'
  get 'about', to: 'pages#about', as: 'about'
  get 'help', to: 'pages#help', as: 'help'
  get 'snap', to: 'pages#snap', as: 'snap'
  get 'run', to: 'pages#snap' # Alias for the old s.b.e shortcut.
  # TODO: ? Alias init/ or tools to preload the tools library?

  get 'users/:id', to: 'users#profile', as: 'user_profile'

  devise_for :users,
             controllers: { sessions: 'sessions',
                            registrations: 'registrations' },
             path_names: { sign_in: 'login',
                           sign_out: 'logout',
                           sign_up: 'signup' }

  # viewable project mappings
  resources :projects #, only: [:show] # , :new, :create
  resources :users do
    resources :projects
  end

  # TODO: Switch to resources :assignments
  get 'assignments/:course_id/new', to: 'assignments#new', as: 'assignment_new'
  post 'assignments/:course_id/create',      to: 'assignments#create', as: 'assignment_create'
  post 'assignments/:assignment_id/update',  to: 'assignments#update', as: 'assignment_update'
  post 'assignments/:assignment_id/delete',  to: 'assignments#delete', as: 'assignment_delete'
  get 'assignments/:assignment_id/edit',     to: 'assignments#edit', as: 'assignment_edit'
  get 'assignments/:assignment_id',          to: 'assignments#show', as: 'assignment_show'

  post 'submissions/:assignment_id/create', to: 'submissions#create', as: 'submission_create'

  post 'courses/create',      to: 'courses#create', as: 'course_create'
  get 'courses/new',          to: 'courses#new', as: 'course_new'
  post 'courses/:course_id/update',  to: 'courses#update', as: 'course_update'
  post 'courses/:course_id/delete',  to: 'courses#delete', as: 'course_delete'
  get 'courses/:course_id/edit',     to: 'courses#edit', as: 'course_edit'
  get 'courses/:course_id',          to: 'courses#show', as: 'course_show'
  get 'courses',              to: 'courses#index', as: 'course_index'

  get '/@/:username', to: 'users#prettyname', as: 'user_prettyname'

  # Cleaner URLs for HTML pages.

  devise_scope :user do
    get 'login', to: 'sessions#new', as: :login
    get 'logout', to: 'sessions#destroy', as: :logout
    get 'signup', to: 'registrations#new', as: :signup
  end

  # NOTE: We should probably use a subdomain in the future, add:
  # constraints: { subdomain: 'api' }, path: '/'
  # Scoping is used so that there isn't a version in the URL
  # FIXME -- force all api stuff to be json, but this line is broken:
  # format: true, contrainsts: {format: :json},
  namespace :api, defaults: { format: :json }  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # Tokens are an easier way to handle API auth.
      resources :users do
        resources :projects, only: [:index]
      end
      resources :projects #, except: [:index]
      # Comments eventually?
      # Classes
      # Assignments / Submissions
    end
  end
end
