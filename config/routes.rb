Rails.application.routes.draw do
  
  # :resources is the different articles/sites that users post 
  resources :resources

  resources :users

  root 'welcome#index'

  delete '/resources', to: 'resources#destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
