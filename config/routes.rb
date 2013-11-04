Swytchat::Application.routes.draw do
 
 mount Resque::Server, :at => "/resque" 

root to: 'rooms#index'
match '/rooms',    to: 'rooms#index', via: :get
match '/users',    to: 'users#index', via: :get
match '/activities/active_users', to: 'activities#active_users', via: :get
  
  resources :messages, only: [:create]

  resources :attach_files, only: [:create, :destroy]

    
    resources :rooms do
             get 'sendnew', :on => :member
             get 'tracking', :on => :member
        end
    
    resources :rooms do
             get 'password_request', :on => :member
             get 'password_check', :on => :member
             end    

  resources :users

  resources :sessions, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
#match '/messages/getnew', to: 'messages#sendnew', via: :get
  
  match '/about',   to: 'static#about', via: :get
  match '/contact', to: 'static#contact', via: :get
  match '/signin',  to: 'sessions#new', via: :get
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/signup',  to: 'users#new', via: :get
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
