Rails.application.routes.draw do
  devise_for :users

  # NOTE: We should probably use a subdomain in the future, add:
  # constraints: { subdomain: 'api' }, path: '/'
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
