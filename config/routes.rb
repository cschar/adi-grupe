Rails.application.routes.draw do
  resources :quests
  resources :locations

  resources :grupes do
    #requires id
    member do
      get :join  # /grupe/1/join

      get :add_quest  #/grupe/1/addquest   #give a page we can post to qglinks create
    end
    resources :qglinks
    resources :grupecomments

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

    member do
      get :trashit, to: 'conversations#set_archived'
      get :untrashit, to: 'conversations#unset_archived'
    end

  end


  #### Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #### Devise
  ## override the omniauth_callbacks controller
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/registrations'
  }

  get '/users/profile', to: 'user_info#profile'


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
  get '/terms', to: 'static_pages#terms'
  get '/privacy', to: 'static_pages#privacy'
  get '/settings/weird', to: 'static_pages#settings_weird'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
