Rails.application.routes.draw do
  
  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, 
                     :path_names => { :sign_up => "register" }

  # :resources is the different articles/sites that users post 
  resources :resources

  post "/vote" => "resources#vote"
  patch "/vote" => "resources#vote"

  resources :users

  resources :topics 
  

  # root 'welcome#index'
  root 'topics#index'


  # I only needed this route when I was using just Oauth
  # get "/auth/:provider/callback" => "sessions#create"

  get "/signout" => "sessions#destroy", :as => :signout
  # get '/auth/github/callback' => 'sessions#create'

  delete '/resources', to: 'resources#destroy'


end
