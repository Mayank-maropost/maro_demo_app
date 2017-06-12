class Photo < ApplicationRecord
  belongs_to :user
  mount_uploader :image_url, ImageUploader

  validates :name, presence: true
  validates :name, :uniqueness => true

  def self.import(file)
  	response_hash= {} 
	  CSV.foreach(file.path, headers: true,encoding: "iso-8859-1:utf-8") do |row|
	    #Photo.create! row.to_hash
	     @photo= Photo.new(name: row.to_hash["name"], remote_image_url_url: row.to_hash["image_url"])
			 unless @photo.valid? && @photo.save!
					return false			
			 end		  		
	  end
	end
end
