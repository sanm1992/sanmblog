class ErrorsController < ApplicationController
  def client_error
    render(:status => 404)
  end

  def server_error
    render(:status => 500)
  end 
end