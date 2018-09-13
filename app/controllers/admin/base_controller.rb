class Admin::BaseController < ApplicationController
	layout 'admin'
	before_action :authenticate_user!

	@@current_user

	def authenticate_user!
    user = session[:user_id].blank? ? nil : User.find_by(id: session[:user_id])
   
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, session[:token])
      @@current_user = user
    else
      redirect_to login_path, notice: "登陆过期，请重新登录"
    end
  end

  def login?
  	@@current_user.present?
  end
end