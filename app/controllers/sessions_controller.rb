class SessionsController < Devise::SessionsController
	def create
		password = params[:user][:password]
		email = params[:user][:email]
		if password.present?
			encrypted_password = Digest::SHA512.hexdigest(password)
			@user = User.find_by_email_and_encrypted_password(email,encrypted_password)
			if @user.nil?
				flash[:alert] = 'Invalid Email or Password'
				redirect_to root_path
			else
				sign_in @user
                redirect_to home_home_index_path
            end
		else
			flash[:alert] = 'Invalid Email or Password'
			redirect_to root_path
		end	
	end
end
