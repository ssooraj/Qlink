class BlogsController < ApplicationController
	before_filter :authorize_user!

	def create 
  params[:blog][:user_id]=current_user.id
 # params[:blog][:tag].gsub(/\'/, '')
  @blog_create = Blog.new(params[:blog])
  if @blog_create.save
               flash[:notice] = "Blog Posted"
  else
     flash[:alert] = "Blog not Posted"           
    end  
    redirect_to  top_blog_blogs_path  
  end

  def my_blog
    @guestuserid=current_user.id
    @blogs_all = Blog.find_by_sql("select * from blogs where user_id=#{@guestuserid} limit 5;")
  end	

  def latest_blog

    @blogs_all = Blog.find_by_sql("select * from blogs order by id DESC limit 3;")
  end 
  
  def top_blog

    @blogs_all = Blog.find_by_sql("select * from blogs order by kudos DESC limit 3;")
  end 

  def view_blog
   @blog_view = Blog.find(params[:id])  
   @comments = @blog_view.comments
   @comment_count = Comment.where(:blog_id => params[:id]).count 
  end

  def add_kudos_blog
  @add = Blog.find(params[:id])
  @add.update_attribute("kudos", @add.kudos + 1)
  redirect_to  :controller=>"blogs", :action=>"view_blog", :id=>params[:id]
 end
 
 def list_by_tags
       tag = params[:tag]
       @blogs_all = Blog.find_by_sql("select * from blogs where tag = '#{params[:tag]}' limit 5;")

          
end


def destroy
    @delete_blog = Blog.find(params[:id])
      @delete_blog.destroy
      respond_to do |format|
          format.js
          format.html { redirect_to  top_blog_blogs_path }    
    end
  end

def kudos_to_blog
    post_id=params[:id]
    @post=Blog.find(post_id)
    if @post.kudos.nil?
      @post.kudos=1
    else
      @post.kudos=@post.kudos + 1
    end
    @post.update_attribute("kudos", @post.kudos)
    KudosToBlog.create(:user_id=>current_user.id, :blog_id=>post_id)
    redirect_to  :controller=>"blogs", :action=>"view_blog", :id=>params[:id]
  end
end

 
