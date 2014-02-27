QLink::Application.routes.draw do


get '/404', to: 'errors#not_found'
get '/500', to: 'errors#server_error'


resources :events do
   member do
   end
   collection do
     post 'save_event'
     get 'index'
     get 'showcalender'
     get 'firstpage'
     get 'invitepeople'
     post 'save_eventemail'
     get 'firstpageremove'
     get 'update_event'
     post 'updatesave_event'
   end
  end
  
resources :profiles do
  member do
  end
  collection do

    get 'profile_form'
    post 'create'
    get 'about'
    get 'events'
    get 'search'
    post 'fill_details'
    post 'add_picture'
    get 'upload_file_for_postmessage'
    get 'photos'
    get 'videos'
    get 'change_profile_pic'  
    post 'save_profile'
    get 'my_posts'
    get 'my_blogs'
    get 'my_discussions'
  end
end
resources :home do
  member do
  end
  collection do
    get 'home'
    post 'create'
    post 'postmessage'
    get 'upload'
    get 'latest_blogs'
    get 'latest_discussions'
    get 'latest_events'
    get 'destroy'
    get 'kudos_to_post'
  end
end

    
match "/contacts/:gmail/callback" => "contacts#contacts_callback"
match "/contacts/failure" => "contacts#failure"
devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :sessions => "sessions"}
root :to => "users#index"
resources :users do
    member do

    end
    collection do
        post 'reset_password'
        get 'welcomepage'  
        get 'skip_import_contacts' 
        get 'skip_add_profile_picture'
        get 'set_password'
        post 'save_password'         
    end
end


resources :discussions do   
  member do
  
  end
  collection do
    get 'view_disc'
   post 'create'
   get 'my_disc'
   get 'top_disc'
   get 'latest_disc'
   get 'add_kudos_discussion'
   get 'list_by_tags'
   get 'destroy'
   get 'kudos_to_discussion'
  end
end

resources :blogs do   
  member do
  
  end
  collection do

    get'add_kudos_blog'
    get 'view_blog'
    post 'create'
    get 'my_blog'
    get 'top_blog'
    get 'latest_blog'
    get 'list_by_tags'
    get 'destroy'
    get 'kudos_to_blog'
  end
end


resources :answers  do
  member do
  end
  collection do
    post 'create_ans'
    get 'add_kudos_answer'
    get 'kudos_to_answer'
  end
end


resources :comments  do
  member do
  end
  collection do
    get 'add_kudos_comments'
    post 'create_comment'
     get 'kudos_to_comment'
  end
end
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
