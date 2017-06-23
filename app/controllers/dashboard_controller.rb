class DashboardController < ApplicationController
	before_action :authenticate_user!, :except => [:error_404]
    #before_filter :is_json?, :only => [:error_404]
	def new
	end

	def error_404
		respond_to do |format|
	      format.html { render 'dashboard/not_found'}
	      format.json { render_message 500, "No routes match!", "Failure" }
	    end
	end

end
