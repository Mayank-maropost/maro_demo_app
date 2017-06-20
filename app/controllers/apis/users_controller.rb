class Apis::UsersController < ApplicationController
	before_filter :is_json?

	def create
		if params[:user].present?
			return	render_message 500, "Email is not found in request", "Failure" unless params[:user][:email].present?
			user= User.new(user_params)
			if user.valid? && user.save!
				render :json => {
	        :responseCode => 200,
	        :responseStatus=> "Success",
	        :responseMessage => "User created Successfully!",
	        :user=> user.as_json(:only => [:id, :access_token])
	      }
			else
				render_message 500,user.errors.full_messages , "Failure"
			end	
		else
			render_message 500, "User hash is missing in request", "Failure"
		end	
	end

	private
	def user_params
		params.require(:user).permit(:email)
	end

end
