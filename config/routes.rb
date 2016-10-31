Rails.application.routes.draw do
  
  # :resources is the different articles/sites that users post 
  resources :resources

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
