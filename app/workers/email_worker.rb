class EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(email,password)
    UserMailer.welcome_email(email,password).deliver
  end
end

