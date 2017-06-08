class StaticContentController < ApplicationController
	before_action :authenticate_user!
	
	def about_us
		
	end

	def contact_us_form
		
	end

	def contact_us_create
		@name= params[:contact_us][:name]
		@email= params[:contact_us][:email]
		@desc= params[:contact_us][:description]
		UserMailer.contact_us_mail(@name,@email,@desc).deliver
		flash[:notice]= "Thank you for contacting us!"
		redirect_to contact_us_form_static_content_index_path
	end
end
