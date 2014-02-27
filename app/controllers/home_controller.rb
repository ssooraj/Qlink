class HomeController < ApplicationController

=begin
Home controller handles the view for all user updates of Q-Link.
=end

before_filter :authorize_user!

#Method to view all the latest user posts on Q-Link with image or video upload option as a parameter.
	def home
		if ((params[:option]=="image")||(params[:option]=="video"))
			@file_option=params[:option]
		else
			@file_option="none"
		end
		@updated_posts=Post.find_by_sql("SELECT * FROM posts order by id DESC")
	end

#Method to update the Post table with the new user post and user id.
	def create
		if((params[:home][:description].nil?)&&(params[:home][:image].nil?))
			flash[:alert] = "Invalid Post"
			redirect_to home_home_index_path
		else
		params[:home][:user_id]=current_user.id
		params[:home][:kudos]=0
		@post=Post.create(params[:home])
		if @post.save
			flash[:notice] = "Post Updated"
			flash[:color]= "valid"
			redirect_to home_home_index_path
		else
			flash[:alert] = "Update unsuccessful"
			flash[:color]= "valid"
			redirect_to home_home_index_path
		end
		end
	end

#Method to create a wall post for the respective user on visited user's wall.
	def postmessage
		#render :json=>{:data=>params[:id]}
		if params[:id]==current_user.id.to_s
			params[:home][:user_id]=current_user.id
		else
			params[:home][:user_id]=current_user.id
			params[:home][:receiver_id]=params[:id]
		end
		@post=Post.create(params[:home])
		if @post.save
			flash[:notice] = "Your Message Posted"
			flash[:color]= "valid"
			redirect_to :controller => "profiles", :action => "my_posts", :id => params[:id]
		else
			flash[:alert] = "Invalid Entry"
			flash[:color]= "valid"
			redirect_to :controller => "profiles", :action => "my_posts", :id => params[:id]
		end
	end

#Method to upload a image or video file for a status post.
	def upload		
		if params[:option]=="image"			
			redirect_to :action=>"home", :option=>params[:option]
		else if params[:option]=="video"			
			redirect_to :action=>"home", :option=>params[:option]
	    	end
		end
	end

#Method to view all the latest blogs of user's in Q-Link. 
	def latest_blogs
		@updated_blogs=Blog.find_by_sql("SELECT * FROM blogs order by id DESC")
	end

#Method to view all the latest discussions of user's in Q-Link. 
	def latest_discussions
		@updated_discussions=Discussion.find_by_sql("SELECT * FROM discussions  order by id DESC")
	end

#Method to view all the latest events of user's in Q-Link. 
	def latest_events
		@updated_events=Userevent.find_by_sql("SELECT * FROM userevents order by id DESC")
	end

#Method to delete a particular post by the respective user.
	def destroy
		@post = Post.find(params[:id])
    	@post.destroy
    	@kudos=KudosToPosts.find_by_post_id(params[:id])
    	@kudos.destroy
    	respond_to do |format|
      		format.js
      		format.html { redirect_to home_home_index_path }		
		end
	end

#Method to enable kudos to a particular post.
	def kudos_to_post
		post_id=params[:id]
		@post=Post.find(post_id)
		if @post.kudos.nil?
			@post.kudos=1
		else
			@post.kudos=@post.kudos + 1
		end
		@post.update_attribute("kudos", @post.kudos)
		KudosToPosts.create(:user_id=>current_user.id, :post_id=>post_id)
		redirect_to home_home_index_path
	end
end
