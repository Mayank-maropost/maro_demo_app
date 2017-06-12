class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #callbacks
  before_create :genrate_random_password
  after_create :send_welcome_mail
  
  #associations
  has_many :photos

  def genrate_random_password
		first_two = (('a'..'z').to_a + ('a'..'z').to_a)
		next_seven= ((0..9).to_a)
		last_digit= (('A'..'Z').to_a)
		password = (0...2).map { |n| first_two.sample }.join + (0...7).map { |n| next_seven.sample }.join + (0...1).map { |n| last_digit.sample }.join
  	self.password= password
  end
  
  def send_welcome_mail
  	UserMailer.welcome_email(self).deliver
  end

  def password_required?
  	false
	end
   
end
