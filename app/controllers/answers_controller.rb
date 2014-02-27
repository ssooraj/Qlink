class AnswersController < ApplicationController
  before_filter :authorize_user!

  def create_ans
    params[:answer][:user_id] = current_user.id
    params[:answer][:discussion_id] = params[:id]
    @post = Answer.new(params[:answer])
    if @post.save
      flash[:notice] = "AnswerPosted"
      redirect_to  :controller=>"discussions", :action=>"view_disc", :id=>params[:id]
    end    
  end

  def add_kudos_answer
    @add = Answer.find(params[:id])
    @add.update_attribute("kudos", @add.kudos + 1)
    redirect_to  :controller=>"discussions", :action=>"view_disc", :id=>params[:id]
  end

def kudos_to_answer
    post_id=params[:id]
    @post=Answer.find(post_id)
    if @post.kudos.nil?
      @post.kudos=1
    else
      @post.kudos=@post.kudos + 1
    end
    @post.update_attribute("kudos", @post.kudos)
    KudosToAnswer.create(:user_id=>current_user.id, :answer_id=>post_id)
    redirect_to  :controller=>"discussions", :action=>"view_disc", :id=>params[:discussion_id]
  end

end
