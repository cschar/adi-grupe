Rails.application.routes.draw do
  resources :locations
  resources :grupes do

    #requires id
    member do
      get :join  # /grupe/1/join
    end
  end
  resources :transactions
  resources :items
  resources :firetrees

  resources :conversations do
    resources :messages

    # doesnt need id
    collection do
      get :inbox
      get :all, action: :index
      get :sent
      get :trash
    end
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



  root 'static_pages#index'

  get 'feature1', to: 'static_pages#feature1'
  get '/readquest', to: 'static_pages#readquest'
  get '/pricing', to: 'static_pages#pricing'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
