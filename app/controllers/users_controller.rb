class UsersController < ApplicationController

	before_filter :authorize_user! , :except => [:index]

	def index
		@user = current_user
		if user_signed_in?
			user = User.find(current_user.id)
            if user.passwordflag == false
                sign_in user
                redirect_to :controller=>"users", :action=>"welcomepage" and return
            end

            profile = Profile.find(current_user.id)
            if (profile.first_name.nil?) || (profile.last_name.nil?)
                redirect_to :controller=>"users", :action=>"welcomepage" and return
            end
            if profile.image_url.nil?
                redirect_to :controller=>"users", :action=>"welcomepage" and return
            end
			redirect_to home_home_index_path and return
		end
		render :layout => 'login'	
	end

	def set_password
	end
	def save_password
		@user = current_user
			if(User.create_password(params[:password][:password]) == @user.encrypted_password)
				if(params[:password][:new_password] == params[:password][:Confirm_new_password])
					flash[:notice] = "Password changed"
					@user.update_attribute(:encrypted_password ,User.create_password(params[:password][:new_password]))
					redirect_to set_password_users_path
				else
					flash[:notice] = "Password Confirmation not ok"
					redirect_to set_password_users_path
	            end
	        else
	        	if(params[:password][:password]==""|| params[:password][:new_password]==""||params[:password][:Confirm_new_password]=="")
	         		flash[:notice] = "Filds can't be blank"
			 		redirect_to set_password_users_path
			    else
					flash[:notice] = "Wrong password"
			 		redirect_to set_password_users_path
				end
			end
	end
	

	def welcomepage
		@user = current_user
		if session[:@welcome] == "done"
			redirect_to home_home_index_path and return
		end
		#render :json=>{:data=>session[:@auth]} 
		@user_profile_info = session[:@auth][:info]
		render :layout => 'welcomepage'
	end

	def reset_password
		@user = current_user
		password = params[:user][:password]
		if password.empty?
			flash[:alert] = "Password entered is blank!"
			redirect_to welcomepage_users_path and return
		else
			@user.update_attribute(:encrypted_password ,User.create_password(password))
			if @user.save
				@user.update_attribute(:passwordflag ,true)
				session[:@welcome]="done"
				redirect_to welcomepage_users_path and return
			end
		end	
	end

	def skip_import_contacts
		session[:@welcome] = "password"
		redirect_to welcomepage_users_path and return
	end

	def skip_add_profile_picture
               session[:@welcome] = "contacts"
               redirect_to welcomepage_users_path and return
    end
end
