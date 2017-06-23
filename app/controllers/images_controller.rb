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
				render :json=> { photo_present: true }
			else
				render :json=> { photo_present: false }
			end			
		end

		def import_images
			begin
     		@photo= Photo.import(params[:file])
     		if @photo[:key]== "failed"
					return redirect_to images_path, notice:  @photo[:message]
				elsif	 @photo[:key]== "name_error"
					return redirect_to images_path, notice:  @photo[:message]
				else
					return redirect_to images_path, notice:  @photo[:message]
				end	
			rescue
     			redirect_to images_path, notice: "Invalid Csv file format!"		
			end
		end

		def image_count
			sleep 1
			photo_count = Photo.count || 0
			render :json=> { photo_count: photo_count }
		end

		private
		def photo_params
			params.require(:photo).permit(:name, :image_url)
		end
end
