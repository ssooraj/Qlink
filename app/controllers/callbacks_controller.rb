class CallbacksController < Devise::OmniauthCallbacksController

require 'google/api_client'
  require 'rubygems'

    skip_before_filter :verify_authenticity_token, :only => [:google]

    def google_oauth2
        
        user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
	    
        if user.persisted?
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"

            sign_in user, :event => :authentication
            @profile=Profile.find_by_user_id(user.id)
            if @profile.nil?
                Profile.create!(:user_id=>user.id, :date_of_birth =>"null", :first_name =>"null", :last_name =>"null", :place =>"null", :gender =>"null")
            end
            user.reset_authentication_token! 
            session[:@auth] =request.env["omniauth.auth"]
            user = User.find(user.id)
            user1 = User.find(current_user.id)
            user1.update_attributes(:token => session[:@auth]["credentials"]["token"],:refresh_token =>session[:@auth]["credentials"]["refresh_token"] )
            if user.passwordflag == false
                session[:@welcome] = "show"
                sign_in user
                flash[:alert] = "Welcome to Q-Link"
                redirect_to :controller=>"users", :action=>"welcomepage" and return
            end
             
            
            #render :json=>{:data=>session[:@auth]}
            redirect_to home_home_index_path           

		    
        else
            session["devise.google_data"] = request.env["omniauth.auth"]
	            #render :json => {:data => session["devise.google_data"] }
     	        redirect_to root_path
        end
    end

	def failure

	redirect_to root_path

	end
end
