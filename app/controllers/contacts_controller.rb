class ContactsController < ApplicationController
	def contacts_callback
		@contacts = request.env['omnicontacts.contacts']
		@contact = Contact.find_by_user_id(current_user.id)

		if @contact.nil?
			@contacts.each do |contact|
				Contact.create!(:user_id => current_user.id, :name => contact[:name], :email => contact[:email])
			end
		else
			Contact.where(:user_id => current_user.id).destroy_all
			@contacts.each do |contact|
				Contact.create!(:user_id => current_user.id, :name => contact[:name], :email => contact[:email])
			end
		end
		flash[:notice] = "you have successfully imported contacts from your account"
		if session[:@welcome] == "done"
			redirect_to home_home_index_path  
		else
			session[:@welcome]="password"
			redirect_to :controller=>"users", :action=>"welcomepage" and return
		end
		
	end

	def failure 
		flash[:alert] = "something went wrong try again"
		redirect_to root_path
	end
end
