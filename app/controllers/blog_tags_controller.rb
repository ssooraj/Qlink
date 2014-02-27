class BlogTagsController < ApplicationController
  before_filter :authorize_user!
  
  def create_ans
    params[:answer][:discussion_id] = params[:id]
    @post = Answer.new(params[:answer])
 
  end
end
