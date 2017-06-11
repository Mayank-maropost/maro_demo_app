class ImagesController < ApplicationController
		before_action :authenticate_user!

		def new
			
		end

		def index
			@photos= Photo.all.page(params[:page]).per(6)
		end

		def create
			@photo = Photo.new(photo_params)
		  if @photo.valid? && @photo.save!
		  	flash[:notice]= "Photo added successfully!"
		  	redirect_to images_path
			else
				flash[:error] = @photo.errors.full_messages
				redirect_to images_path
			end	
		end

		def destroy
			@photo= Photo.find_by(id: params[:id])
			@photo.destroy
			flash[:notice]= "Photo deleted successfully!"
		  redirect_to images_path
		end

		
		def edit
			@photo= Photo.find_by(id: params[:id])
		end

		def update
			 @photo= Photo.find_by(id: params[:id])
			 @photo.assign_attributes(photo_params)	
		   if @photo.valid? && @photo.save
 		      redirect_to images_path, notice: "Photo Updated Successfully!"
	    else
				  redirect_to images_path, notice: @photo.errors.full_messages.first
			end
		end

		def get_image_detail
			@photo= Photo.find_by(id: params[:id])
			render :json=> { photo_name: @photo.name }
		end

		def check_image_name
			@photo = Photo.find_by_name(params[:name])
			if @photo
				p "=====if"
					render :json=> { photo_present: true }
			else
				p "else===="
					render :json=> { photo_present: false }
			end			
		end

		private
		def photo_params
			params.require(:photo).permit(:name, :image_url)
		end
end
