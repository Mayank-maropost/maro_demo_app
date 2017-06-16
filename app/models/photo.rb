class Photo < ApplicationRecord
require 'csv'

  belongs_to :user
  mount_uploader :image_url, ImageUploader

  validates :name, presence: true
  validates :name, :uniqueness => true

  def self.import(file)
  	response_hash= {}
  	count=0 
  	csv = CSV.open(file.path, :headers => true)
		csv.read
		headers= csv.headers
		arr= ["name", "image_url"] 
		reverse_arr = ["image_url", "name"]
    unless  headers== arr || headers== reverse_arr
  		response_hash[:key]= "failed"
  		response_hash[:message]= "You are missing the header!"
		  return response_hash
		else  
			CSV.foreach(file.path, headers: true, skip_blanks: true, skip_lines: /^(?:,\s*)+$/, header_converters: :symbol, encoding: "iso-8859-1:utf-8"	) do |row|
	    	if (row[:name].present? && row[:image_url].present?)
		    		@photo= Photo.new(name: row[:name], remote_image_url_url: row[:image_url])
	    		  unless @photo.valid? && @photo.save!
							response_hash[:key]= "name_error"
		    	  	response_hash[:message]= "#{@photo.errors.full_messages.join(',')}! #{count} photos imported"
		    	  	return response_hash
	    	  	else
	    	  		count= count+1
			 		  end		
	    	else
	    	  response_hash[:key]= "failed"
	    	  paramater= row[:image_url].blank? ? "image_url" : "name"
	    	  response_hash[:message]= "You are missing the values of #{paramater}!  #{count} photos imported"
	    	  return response_hash
	    	end
			end
			if count.eql?(0)
	  		response_hash[:message]= "No row found!"
	  	else
	  		response_hash[:message]= "Photo imported succesfully! #{count} photos imported"
		  end
		  return response_hash
		end  
	end
end
