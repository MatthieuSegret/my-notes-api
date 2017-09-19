Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get 'welcomes/hello', to: 'welcomes#hello'
      get 'notes', to: 'notes#index'
      get 'notes/:id', to: 'notes#show'
      delete 'notes/:id', to: 'notes#destroy'
    end
  end
end
