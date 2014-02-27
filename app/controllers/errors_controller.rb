class ErrorsController < ApplicationController
  def not_found
    render status: 404 ,:layout => false
  end

 def server_error
    render status: 500, :layout => false
  end
end