Rocksaga::Application.routes.draw do
  root :to => "game#index"
  
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/signin' => 'sessions#new', :as => :signin, via: [:get, :post]
  match '/signout' => 'sessions#destroy', :as => :signout, via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: [:get, :post]

  resources :users, :only => [:show]
  resources :scores
end
