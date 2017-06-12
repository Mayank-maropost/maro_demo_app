Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => 'dashboard#new'
  devise_for :users 
  #devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  resources :dashboard, only: [:new] 
  
  resources :images do
    collection do
      get 'get_image_detail'
      get 'check_image_name'
      post 'import_images'
    end  
  end 

  resources :static_content, only: [:new] do
  	collection do 
  		get 'about_us'
      get 'contact_us_form'
      post 'contact_us_create'
  	end	
  end	

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

end
