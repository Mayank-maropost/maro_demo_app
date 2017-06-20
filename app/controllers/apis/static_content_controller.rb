class Apis::StaticContentController < ApplicationController
	before_filter :is_json?

	def contact_us
		if params[:contact_us].present?
		  return	render_message 500, "name is not found in request", "Failure" unless params[:contact_us][:name].present?
		  return	render_message 500, "email is not found in request", "Failure" unless params[:contact_us][:email].present?
		  return	render_message 500, "description is not found in request", "Failure" unless params[:contact_us][:description].present?
			name= params[:contact_us][:name]
			email= params[:contact_us][:email]
			desc= params[:contact_us][:description]
			UserMailer.contact_us_mail(name,email,desc).deliver rescue  (return render_message 500,"Some error found in sending mail!", "Failure")
			render_message 200, "Success","Thank you for contacting us!"
		else
			render_message 500, "Contact hash is missing in request", "Failure"
		end	
	end



end
