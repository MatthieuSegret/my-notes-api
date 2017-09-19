Rails.application.routes.draw do
  get 'welcomes/hello', to: 'welcomes#hello'
  get 'notes', to: 'notes#index'
end
