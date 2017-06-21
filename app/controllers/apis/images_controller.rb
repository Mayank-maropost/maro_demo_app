class Apis::ImagesController < ApplicationController
	before_filter :is_json?
	before_filter :find_user, only:[:create]
	
	def create
		return	render_message 500, "Name is not found in request", "Failure" unless params[:image][:name].present?
		return	render_message 500, "Image url is not found in request", "Failure" unless params[:image][:image_url].present?
		params[:image][:image_url] = Photo.image_data(params[:image][:image_url]) 
		photo= @user.photos.new(image_params)
		if photo.valid? && photo.save!
			render :json => {
	        :responseCode => 200,
	        :responseStatus=> "Success",
	        :responseMessage => "Image created Successfully!",
	        :photo=> photo.as_json(:only => [:id, :name]).merge(image_url: photo.image_url.url)
	      }
		else
			render_message 500,photo.errors.full_messages , "Failure"
		end		
	end

	def show
		photo= Photo.find_by_id(params[:id])
		if photo.present?
			render :json => {
	        :responseCode => 200,
	        :responseStatus=> "Success",
	        :responseMessage => "Image fetched Successfully!",
	        :photo=> photo.as_json(:only => [ :name]).merge(image_url: photo.image_url.url)
	      }
		else
			render_message 500,"Image doesn't exist with this id", "Failure"
		end	
	end

	private
	def image_params
		params.require(:image).permit(:name, :image_url)
	end
end
