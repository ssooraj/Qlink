class DiscussionsController < ApplicationController

 
 before_filter :authorize_user!
 
 def create 
   params[:discussion][:user_id]=current_user.id
   @disc_create = Discussion.new(params[:discussion])
   if @disc_create.save
     flash[:notice] = "Question Posted"
     redirect_to  top_disc_discussions_path
   end    
 end

 def my_disc
    @guestuserid=current_user.id
    @discussion_all = Discussion.find_by_sql("select * from discussions where user_id=#{@guestuserid} limit 5;")

 end	

def latest_disc

    @discussion_all = Discussion.find_by_sql("select * from discussions order by id DESC limit 3;")
  end 
  
  def top_disc

    @discussion_all = Discussion.find_by_sql("select * from discussions order by kudos DESC limit 3;")
  end 

 def view_disc
   @discussion = Discussion.find(params[:id])  
  
   @answers = @discussion.answers
 end
 
 def add_kudos_discussion
  @add = Discussion.find(params[:id])
  @add.update_attribute("kudos", @add.kudos + 1)
  redirect_to  :controller=>"discussions", :action=>"view_disc", :id=>params[:id]
 end

 def list_by_tags
       tag = params[:tag]
      @discussion_all = Blog.find_by_sql("select * from discussions where tag = '#{params[:tag]}' limit 5;")

          
end

def destroy
    @delete_disc = Discussion.find(params[:id])
      @delete_disc.destroy
      respond_to do |format|
          format.js
          format.html { redirect_to  top_disc_discussions_path }    
    end
  end

  def kudos_to_discussion
    post_id=params[:id]
    @post=Discussion.find(post_id)
    if @post.kudos.nil?
      @post.kudos=1
    else
      @post.kudos=@post.kudos + 1
    end
    @post.update_attribute("kudos", @post.kudos)
    KudosToDiscussion.create(:user_id=>current_user.id, :discussion_id=>post_id)
    redirect_to  :controller=>"discussions", :action=>"view_disc", :id=>params[:id]
  end

end