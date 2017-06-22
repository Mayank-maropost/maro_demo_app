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
      get 'image_count'
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

  # apis routes
  namespace :apis do
    resources :static_content, only: [:new] do
      collection do 
        post 'contact_us'
      end 
    end 
    resources :users, only: [:create] 
    resources :images, only:[:create, :show]
  end  

    # having created corresponding controller and action
    get '*path', to: 'dashboard#error_404', via: :all
    post '*path', to: 'dashboard#error_404', via: :all
    put '*path', to: 'dashboard#error_404', via: :all
    delete '*path', to: 'dashboard#error_404', via: :all

end
