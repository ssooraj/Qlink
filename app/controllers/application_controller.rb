class ApplicationController < ActionController::Base


	protect_from_forgery

	def after_sign_in_path_for(user)
		#user.reset_authentication_token!
    	about_profiles_path
  	end

  	def after_sign_out_path_for(user)
  		root_path
  	end

   	protected
	def authorize_user!
	    if user_signed_in?
	    
	    else
	      	flash[:alert] = 'You need to sign in first'
	      	redirect_to root_path
	    end
	end

	protected
	def client_call
            user = User.find(current_user.id)
                    options = {
   			body: {
     		client_id: '935182387541.apps.googleusercontent.com',
     		client_secret: 'xGD61KoGpOhnurYtRWNcZJ3l',
     		refresh_token: user.refresh_token,
     		grant_type: 'refresh_token'
   			},
   			headers: {
     		'Content-Type' => 'application/x-www-form-urlencoded'
   			}
 			}
 			@response = HTTParty.post('https://accounts.google.com/o/oauth2/token', options)
 			if @response.code == 200
  			 	user.token = @response.parsed_response['access_token']
   				user.save
 			end
            @client = Google::APIClient.new 
            @client.authorization.access_token = user.token
            @client.authorization.client_id = '935182387541.apps.googleusercontent.com'
            @client.authorization.client_secret = 'xGD61KoGpOhnurYtRWNcZJ3l'
            @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
            return @client
	end

end
