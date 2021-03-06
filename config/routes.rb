Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      get 'welcomes/hello', to: 'welcomes#hello'

      post 'users/auth', to: 'users#auth'
      post 'users/refresh_token', to: 'users#refresh_token'
      delete 'users/revoke_refresh_token', to: 'users#revoke_refresh_token'
      devise_for :users, module: 'devise', singular: :user, only: [:registrations]

      resources :notes do
        get :search, on: :collection
        resources :comments, only: [:create]
      end
    end
  end
end
