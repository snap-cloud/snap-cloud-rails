# Our constraints around versioning.
require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users, :path => 'api/users', :path_names => {
                                            :sign_in => 'login',
                                            :sign_out => 'logout',
                                            :sign_up => 'signup' }

  # Redirect simple requets for the viewable app
  get '/login', to: redirect('api/users/login')
  get '/logout', to: redirect('')
  get '/signup', to: redirect('api/users/signup')

  # NOTE: We should probably use a subdomain in the future, add:
  # constraints: { subdomain: 'api' }, path: '/'
  # Scoping is used so that there isn't a version in the URL
  namespace :api, defaults: { format: :json }  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users do
        resources :projects
      end
      resources :projects
    end
  end


end
