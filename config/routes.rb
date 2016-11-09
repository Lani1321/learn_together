Rails.application.routes.draw do
  
  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, 
                     :path_names => { :sign_up => "register" }
  
  get '/resources/top_resources' => 'resources#top_resources'
  
  # :resources is the different articles/sites that users post 
  resources :resources 



  post "/upvote" => "resources#upvote"
  patch "/upvote" => "resources#upvote"

  post "/downvote" => "resources#downvote"
  patch "/downvote" => "resources#downvote"

  resources :users

  resources :topics do
    get "/resources/new" => "topics#new_resource"
    post "resources/new" => "topics#create_resource"
  end

  resources :topics do 
    resources :resources, only: [:index]
  end

  # root 'welcome#index'
  root 'topics#index'


  # I only needed this route when I was using just Oauth
  # get "/auth/:provider/callback" => "sessions#create"

  get "/signout" => "sessions#destroy", :as => :signout
  # get '/auth/github/callback' => 'sessions#create'

  delete '/resources', to: 'resources#destroy'
  delete '/resources', to: 'topics#destroy'


end
