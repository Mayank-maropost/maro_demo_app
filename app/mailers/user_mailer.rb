class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
   
  def welcome_email(email,password)
    @password= password
    @url  = 'http://192.168.3.3/users/sign_in'
    @email= email
    mail(to: @email, subject: 'Welcome to My Demo app')
  end

  def contact_us_mail name,email,desc
   	@name= name
   	@email= email
   	@desc= desc
   	mail(to: @email, subject: 'Contact Us')
  end

end
