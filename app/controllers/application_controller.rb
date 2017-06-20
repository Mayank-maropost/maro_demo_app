class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception, unless: -> { request.format.json? } 
  protect_from_forgery with: :null_session, unless: -> { request.format.json? } 

  
   # rescue_from ActionController::RoutingError, with: -> { render_404  }

  def render_message code,message,status
    render :json => {:responseCode => code,:responseStatus=>status, :responseMessage => message}
  end
  
  def is_json?
    if request.format != :json
       render_message 500,"The request must be json.","Failure"
    end
  end

  def find_user
    render_message 500, "Need HTTP_ACCESS_TOKEN in header.", "Failure" and return if request.headers["HTTP_ACCESS_TOKEN"].nil?
    @user = User.find_by(:access_token => request.headers["HTTP_ACCESS_TOKEN"].to_s)
    unless @user
      render_message 500, "User does not exits with this access token", "Failure"
    end
  end

 # def render_404
 #    respond_to do |format|
 #        format.html { render 'dashboard/not_found'}
 #        format.json { render_message 500, "No routes match!", "Failure" }
 #      end
 # end

end
