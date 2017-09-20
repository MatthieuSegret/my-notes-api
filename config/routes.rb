Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'welcomes/hello', to: 'welcomes#hello'
      resources :notes do
        get :search, on: :collection
        resources :comments, only: [:create]
      end
    end
  end
end
