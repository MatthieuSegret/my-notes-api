Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      get 'welcomes/hello', to: 'welcomes#hello'

      devise_for :users, module: 'devise', singular: :user, only: [:registrations]

      resources :notes do
        get :search, on: :collection
        resources :comments, only: [:create]
      end
    end
  end
end
