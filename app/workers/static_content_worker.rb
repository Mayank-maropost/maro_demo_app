class StaticContentWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(name,email,desc)
    UserMailer.contact_us_mail(name,email,desc).deliver
  end
end

