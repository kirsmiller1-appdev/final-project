Rails.application.routes.draw do

match("/", { :controller => "users", :action => "home", :via => "get"})

  # Routes for the Follow request resource:

  # CREATE
  match("/insert_follow_request", { :controller => "follow_requests", :action => "create", :via => "post"})
          
  # READ
  match("/follow_requests", { :controller => "follow_requests", :action => "index", :via => "get"})
  
  match("/follow_requests/:id_from_path", { :controller => "follow_requests", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_follow_request/:id_from_path", { :controller => "follow_requests", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_follow_request/:id_from_path", { :controller => "follow_requests", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the User comment resource:

  # CREATE
  match("/insert_user_comment", { :controller => "user_comments", :action => "create", :via => "post"})
          
  # READ
  match("/user_comments", { :controller => "user_comments", :action => "index", :via => "get"})
  
  match("/user_comments/:id_from_path", { :controller => "user_comments", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_user_comment/:id_from_path", { :controller => "user_comments", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_user_comment/:id_from_path", { :controller => "user_comments", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the User rating resource:

  # CREATE
  match("/insert_user_rating", { :controller => "user_ratings", :action => "create", :via => "post"})
          
  # READ
  match("/user_ratings", { :controller => "user_ratings", :action => "index", :via => "get"})
  
  match("/user_ratings/:id_from_path", { :controller => "user_ratings", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_user_rating/:id_from_path", { :controller => "user_ratings", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_user_rating/:id_from_path", { :controller => "user_ratings", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Tag resource:

  # CREATE
  match("/insert_tag", { :controller => "tags", :action => "create", :via => "post"})
          
  # READ
  match("/tags", { :controller => "tags", :action => "index", :via => "get"})
  
  match("/tags/:id_from_path", { :controller => "tags", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_tag/:id_from_path", { :controller => "tags", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_tag/:id_from_path", { :controller => "tags", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Inventory resource:

  # CREATE
  match("/insert_inventory", { :controller => "inventories", :action => "create", :via => "post"})
          
  # READ
  match("/inventories", { :controller => "inventories", :action => "index", :via => "get"})
  match("/inventories/new", { :controller => "inventories", :action => "new", :via => "get"})
  
  match("/inventories/:id_from_path", { :controller => "inventories", :action => "show", :via => "get"})
  
  match("/chicago", { :controller => "inventories", :action => "index_chicago", :via => "get"})
  match("/sf", { :controller => "inventories", :action => "index_sf", :via => "get"})
  match("/drank", { :controller => "inventories", :action => "index_drank", :via => "get"})
  match("/inventories_all", { :controller => "inventories", :action => "index_all", :via => "get"})

  # UPDATE
  
  match("/modify_inventory/:id_from_path", { :controller => "inventories", :action => "update", :via => "post"})

  # REMOVE FROM INVENTORY 
  match("/remove_inventory/:id_from_path", { :controller => "inventories", :action => "remove", :via => "get"})
  
  # DELETE
  match("/delete_inventory/:id_from_path", { :controller => "inventories", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Wine resource:

  # CREATE
  match("/insert_wine", { :controller => "wines", :action => "create", :via => "post"})
          
  # READ
  match("/wines", { :controller => "wines", :action => "index", :via => "get"})
  match("/wines/vintage/:vintage_from_path", { :controller => "wines", :action => "index_vintage", :via => "get"})
  match("/wines/vineyard/:vineyard_from_path", { :controller => "wines", :action => "index_vineyard", :via => "get"})
  match("/wines/blend/:blend_from_path", { :controller => "wines", :action => "index_blend", :via => "get"})
  match("/wines/tag/:tag_from_path", { :controller => "wines", :action => "index_tag", :via => "get"})
  match("/wines/rating/:rating_from_path", { :controller => "wines", :action => "index_rating", :via => "get"})
  
  match("/wines/:id_from_path", { :controller => "wines", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_wine/:id_from_path", { :controller => "wines", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_wine/:id_from_path", { :controller => "wines", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for signing up

  match("/user_sign_up", { :controller => "users", :action => "new_registration_form", :via => "get"})
  
  # Routes for signing in
  match("/user_sign_in", { :controller => "user_sessions", :action => "new_session_form", :via => "get"})
  
  match("/user_verify_credentials", { :controller => "user_sessions", :action => "add_cookie", :via => "post"})
  
  # Route for signing out
  
  match("/user_sign_out", { :controller => "user_sessions", :action => "remove_cookies", :via => "get"})
  
  # Route for creating account into database 

  match("/post_user", { :controller => "users", :action => "create", :via => "post" })
  
  # Route for editing account
  
  match("/edit_user", { :controller => "users", :action => "edit_registration_form", :via => "get"})
  
  match("/patch_user", { :controller => "users", :action => "update", :via => "post"})
  
  # Route for removing an account
  
  match("/cancel_user_account", { :controller => "users", :action => "destroy", :via => "get"})


  #------------------------------

  # ======= Add Your Routes Above These =============
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
