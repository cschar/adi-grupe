Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  resources :lmarkers
  devise_for :users
  get '/users/info', to: 'user_info#show', constraints: lambda { |req| req.format == :json }

  get 'hello_world', to: 'hello_world#index'

  # get '/markers', to ''

  get '/arven', to: 'arven#index'
  root 'static_pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
