class CommentsController < ApplicationController
  before_filter :authorize_user!

  def create_comment
  	params[:comment][:user_id] = current_user.id
    params[:comment][:blog_id] = params[:id]
    @com_create= Comment.new(params[:comment])
    if @com_create.save

       flash[:notice] = "Comment Posted"
       redirect_to  :controller=>"blogs", :action=>"view_blog", :id=>params[:id]
    end    
  end

  def add_kudos_comments
     @add = Comment.find(params[:id])
     @add.update_attribute("kudos", @add.kudos + 1)
     redirect_to  :controller=>"blogs", :action=>"view_blog", :id=>params[:id]
  end

  def kudos_to_comment
    post_id=params[:id]
    @post=Comment.find(post_id)
    if @post.kudos.nil?
      @post.kudos=1
    else
      @post.kudos=@post.kudos + 1
    end
    @post.update_attribute("kudos", @post.kudos)
    KudosToComment.create(:user_id=>current_user.id, :comment_id=>post_id)
    redirect_to  :controller=>"blogs", :action=>"view_blog", :id=>params[:blog_id]
  end

end
