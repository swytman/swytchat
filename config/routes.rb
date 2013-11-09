Swytchat::Application.routes.draw do
 
 mount Resque::Server, :at => "/resque" 

root to: 'rooms#index'
match '/rooms',    to: 'rooms#index', via: :get
match '/activities/active_users', to: 'activities#active_users', via: :get
  
  resources :messages, only: [:create]

  resources :attach_files, only: [:create, :destroy]

    
    resources :rooms do
             get 'sendnew', :on => :member
             get 'tracking', :on => :member
             get 'password_request', :on => :member
             get 'password_check', :on => :member
    end    

  resources :users, only: [:new, :create, :destroy, :show, :index, :edit, :update]

  resources :sessions, only: [:new, :create, :destroy]

  
  match '/about',   to: 'static#about', via: :get
  match '/contact', to: 'static#contact', via: :get
  match '/signin',  to: 'sessions#new', via: :get
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/signup',  to: 'users#new', via: :get

end
