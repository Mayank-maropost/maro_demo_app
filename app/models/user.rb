class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #callbacks
  before_create :genrate_random_password
  before_create :generate_access_token
  after_create :send_welcome_mail
  
  #associations
  has_many :photos, dependent: :destroy

  def genrate_random_password
		first_two = (('a'..'z').to_a + ('a'..'z').to_a)
		next_seven= ((0..9).to_a)
		last_digit= (('A'..'Z').to_a)
		password = (0...2).map { |n| first_two.sample }.join + (0...7).map { |n| next_seven.sample }.join + (0...1).map { |n| last_digit.sample }.join
  	self.password= password
  end
  
  def send_welcome_mail
    email= self.email
    password= self.password
  	#UserMailer.welcome_email(self).deliver
    EmailWorker.perform_async(email,password)
  end

  def password_required?
  	false
	end

  private
  #Generating access token for user before creating
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
   
end
