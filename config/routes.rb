Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'welcomes/hello', to: 'welcomes#hello'
      resources :notes
    end
  end
end
