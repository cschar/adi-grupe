Rails.application.routes.draw do
  resources :locations
  resources :grupes
  resources :transactions
  resources :items
  resources :firetrees

  resources :conversations do
    resources :messages
  end


  #### Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #### Devise
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  get '/users/info', to: 'user_info#show', constraints: lambda { |req| req.format == :json }


  ## Geo game
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  resources :lmarkers


  get '/readquest', to: 'static_pages#readquest'
  root 'static_pages#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
