Rails.application.routes.draw do
  devise_for :users

  get 'hello_world', to: 'hello_world#index'

  get '/signup', to: 'static_pages#index'
  get '/login', to: 'static_pages#index'
  get '/logout', to: 'static_pages#index'

  get '/arven', to: 'arven#index'
  root 'static_pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
