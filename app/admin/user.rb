ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :email, :password

filter :email
	index do
	  column :email
	  column "Last Sign In At", :last_sign_in_at
	  column :created_at
	  column :updated_at
	  actions
	end
	
  # show :title => :email do
  #   attributes_table do
  #     row :email do
  #       user.email
  #     end
  #   end
  # end

   form do |f|
    f.inputs do
      f.input :email,label: 'Email'
      f.input :password,label: 'Password'
    end
    f.actions
  end

end
