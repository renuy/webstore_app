JbkidsApp::Application.routes.draw do

  resources :signups

  resources :renewals

  resources :payments 
  
  resources :plans
      

  resources :suggestions do 
    collection do
      get 'pattern'
    end
  end

  resources :list_items 
  #do
  #  collection do
  #    get 'upsert'
  #  end
  #end
  resources :book_lists do
    collection do
      get 'index_k'
    end
  end

  resources :items

  resources :orders

  resources :reviews do
    collection do
      get 'search'
      get 'upsert'
    end
  end
  resources :titles do
    collection do
      get 'refine'
      get 'favourite'
    end
    
  end
  
  devise_for :users, :controllers => {:registrations => 'registrations'} 
  devise_scope :user do 
    get '/users/current' => "registrations#show", :as => 'current_user'
    get '/users/add' => "registrations#add", :as => 'add_kid_profile'
    post '/users/kid' => "registrations#kid", :as => 'kid_profile' 
    resources :users, :only => [:add, :show, :kid] 
  end 
  
  resources :pending_titles_for_collections

  resources :batches

  resources :serialised_titles

  resources :series

  resources :collections

  resources :collection_names

  resources :authors, :branches, :stock
  get "titles/index"
  get "catalogue/index"
  get "dashboard/index"

  match "catalogue" => "catalogue#index"
  match "dashboard" => "dashboard#index"
  match "dashboard/:shelf" => "dashboard#show" ,:as => 'show_dashboard'
  match "myshelf" => "myshelf#index"
  match "show_collection_name" => "collection_names#show"
  match "show_myshelf" => "myshelf#show"
  match "myshelves/:shelf" => "myshelf#show"
  match "gatewayentry" => "payments#gatewayentry" , :via => :post
  
  match "list_items/upsert/:title_id" => "list_items#upsert"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "dashboard#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
