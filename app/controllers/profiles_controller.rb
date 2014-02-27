class ProfilesController < ApplicationController

=begin
Profiles controller handles all the views related to a particular user. The user's 
profile (about), user's posts, user's photos, users's videos and user's events.
=end

before_filter :authorize_user!

#Method to update the user profile via a form.
	def profile_form
		@profile=Profile.find_by_user_id(current_user.id)
	end

#Method displays the user profile details.
	def about		
		if params[:id].nil?	
			@profile=Profile.find_by_user_id(current_user.id)
			@user=User.find(current_user.id)
		else
			@profile=Profile.find_by_user_id(params[:id])
			@user=User.find(params[:id])
		end
					
	end

#To update the user profile.
	def create
		params[:profile][:user_id]=current_user.id
		@profile=Profile.find_by_user_id(current_user.id)
		@profile.update_attributes(params[:profile])
		if @profile.save
			flash[:notice] = "Profile Updated"
			flash[:color]= "valid"
			redirect_to about_profiles_path
		else
			flash[:alert] = "Invalid Entry"
			flash[:color]= "valid"
			redirect_to profile_form_profiles_path
		end
	end

#Method displays all the evenst added by the respective user in Q-Link.	
	def events
		if params[:id].nil?
			@guestuserid=current_user.id
		else
			@guestuserid=params[:id]
		end
			@profile=Profile.find_by_user_id(@guestuserid)
			@updatedevents=Userevent.find_by_sql("select * from userevents where user_id=#{@guestuserid} order by id DESC")
	end

#Method searches for a particular user via user's First Name.
	def search
		# @search = Profile.search do
  #   		fulltext params[:search]
  # 		end
  		search = "%#{params[:search]}%"
  		@search_result = Profile.where("first_name like (?) OR last_name like (?)", search, search)
  		#@search_result = @search.results
  		#render :json=>{:data=>@profile[0].user_id}
	end

#Modal feature method to update the profile picture during Introductory Module setup.
	def fill_details
		params[:profile][:user_id]=current_user.id
		@profile=Profile.find_by_user_id(current_user.id)
		@profile.update_attributes(params[:profile])
		if @profile.save
			session[:@welcome]="avatar"
			redirect_to welcomepage_users_path and return
        else
          	flash[:alert]= "some fields are missing"
			redirect_to welcomepage_users_path 
		end
	end

#Method to upload a file to be posted on the respective user's wall.
	def upload_file_for_postmessage		
		if params[:option]=="image"			
			redirect_to :action=>"my_posts", :option=>params[:option], :id=>params[:id]
		else if params[:option]=="video"			
				redirect_to :action=>"my_posts", :option=>params[:option], :id=>params[:id]
	    	end
		end
	end

#Method to display all the photos uploaded by the respective user.
	def photos
		if params[:id].nil?	
			@profile=Profile.find_by_user_id(current_user.id)
			@user=User.find(current_user.id)
			@photos=Post.find_by_sql("select * from posts where user_id='#{current_user.id}' and image=image;")
			#@wall_photos=Post.find_by_sql("select * from posts where receiver_id='#{current_user.id}' and image=image;")
		else
			@profile=Profile.find_by_user_id(params[:id])
			@user=User.find(params[:id])
			@photos=Post.find_by_sql("select * from posts where user_id='#{params[:id]}' and image=image;")
			#@wall_photos=Post.find_by_sql("select * from posts where receiver_id='#{params[:id]}' and image=image;")
			#render :json=>{:data=>@photos[0].image_url}
		end
	end

#Method to display all the videos uploaded by the respective user.
	def videos
		if params[:id].nil?	
			@profile=Profile.find_by_user_id(current_user.id)
			@user=User.find(current_user.id)
			@videos=Post.find_by_sql("select * from posts where user_id='#{current_user.id}' and video=video;")
			#@wall_videos=Post.find_by_sql("select * from posts where receiver_id='#{current_user.id}' and video=video;")
		else
			@profile=Profile.find_by_user_id(params[:id])
			@user=User.find(params[:id])
			@videos=Post.find_by_sql("select * from posts where user_id='#{params[:id]}' and video=video;")
			#@wall_videos=Post.find_by_sql("select * from posts where receiver_id='#{params[:id]}' and video=video;")
		end
	end

#Method to render the view for profile picture update.
 	def change_profile_pic

	end

#Method to save the new updated profile picture.
	def save_profile
		user = current_user
		profile = Profile.find_by_user_id(current_user.id)
		profile.update_attributes(params[:profpic])
		redirect_to change_profile_pic_profiles_path
	end

#Modal feature method used to set profile picture in Introductory module.
	def add_picture
		@profile=Profile.find_by_user_id(current_user.id)
		if params[:profile].nil?
			flash[:alert] = "You haven't selected any file "
			redirect_to welcomepage_users_path and return
		else
			@profile.update_attributes(params[:profile])
		end
		if @profile.save
			session[:@welcome]="contacts"
			redirect_to welcomepage_users_path and return
		end
	end

#Method to display the respective user's latest posts.
	def my_posts
		if ((params[:option]=="image")||(params[:option]=="video"))
			@option=params[:option]
		else
			@option="none"
		end
		if params[:id].nil?	
			@guestuserid=current_user.id
		else
			@guestuserid=params[:id]
		end			
			@profile=Profile.find_by_user_id(@guestuserid)			
			@my_posts=Post.where("user_id = ?", @guestuserid).reverse
			#render :json=>{:data=>@my_posts}
			@my_messages=Post.where("receiver_id = ?", @guestuserid).reverse
		
	end

#Method to display the respective user's latest blog posts.
	def my_blogs
		if params[:id].nil?	
			@guestuserid=current_user.id
		else
			@guestuserid=params[:id]
		end			
			@profile=Profile.find_by_user_id(@guestuserid)
			@my_blogs=Blog.find_by_sql("select * from blogs where user_id=#{@guestuserid} order by id DESC")
	end

#Method to display teh respective user's latest discussion posts.
	def my_discussions
		if params[:id].nil?	
			@guestuserid=current_user.id
		else
			@guestuserid=params[:id]
		end			
			@profile=Profile.find_by_user_id(@guestuserid)
			@my_discussions=Discussion.find_by_sql("select * from discussions where user_id=#{@guestuserid} order by id DESC")
	end
end
