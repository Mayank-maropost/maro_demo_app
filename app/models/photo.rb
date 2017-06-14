class Photo < ApplicationRecord
require 'csv'

  belongs_to :user
  mount_uploader :image_url, ImageUploader

  validates :name, presence: true
  validates :name, :uniqueness => true

  def self.import(file)
  	p "====self=====#{file}"
  	response_hash= {}
  	count=0 
  	byebug
  	headers = CSV.read(file.path, headers: true).headers
  	if headers.blank?
  		response_hash[:key]= "failed"
  		response_hash[:message]= "No header found!"
		  return response_hash
		else  

				CSV.foreach(file.path, headers: true, skip_blanks: true, skip_lines: /^(?:,\s*)+$/, header_converters: :symbol, encoding: "iso-8859-1:utf-8"	) do |row|
		    	p "====#{row}"

		    	  unless [:name, :image_url].all? { |header| row.headers.include? header }
			     p "==="  
			    	response_hash[:key]= "failed"
			    	 # response_hash[:message]= "You are missing the 'name' header!" if row.headers[0].nil?
			    	 # response_hash[:message]= "You are missing the 'image_url' header!" if row.headers[1].nil?
			    	 #  unless (row.headers.include?(("image_url").parameterize.underscore.to_sym) && row.headers.include?(("name").parameterize.underscore.to_sym))
			    		response_hash[:message]= "You are missing the header!"
			    	  # end
			    	return response_hash
			    else
			    	p "==="
			    	if (row[:name].present? && row[:image_url].present?)
			    		@photo= Photo.new(name: row[:name], remote_image_url_url: row[:image_url])
		    		  unless @photo.valid? && @photo.save!
								response_hash[:key]= "name_error"
			    	  	response_hash[:message]= "Name already taken! #{count} photos imported"
			    	  	return response_hash
		    	  	else
		    	  		p "=====success"
		    	  		count= count+1
				 		  end		
			    	else
			    		p "==else==="
			    	  response_hash[:key]= "failed"
			    	  paramater= row[:image_url].blank? ? "image_url" : "name"
			    	  response_hash[:message]= "You are missing the values of #{paramater}!  #{count} photos imported"
			    	  return response_hash
			    	end	
			    end

			  end
			  	response_hash[:message]= "Photo imported succesfully! #{count} photos imported"
				  return response_hash
	
		end  
	end
end
