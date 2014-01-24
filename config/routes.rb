Rocksaga::Application.routes.draw do
  root :to => "home#index"
  
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/signin' => 'sessions#new', :as => :signin, via: [:get, :post]
  match '/signout' => 'sessions#destroy', :as => :signout, via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: [:get, :post]

  resources :users, :only => [:index, :show, :edit, :update]
end
