class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
   
   def welcome_email(user)
      @user = user
      @url  = 'http://192.168.3.3/users/sign_in'
      @email= user.email
      mail(to: @user.email, subject: 'Welcome to My Demo app')
   end

end
