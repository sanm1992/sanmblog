class Admin::BaseController < ApplicationController
	layout 'admin'
	before_action :authenticate_user!

	@@current_user

	def authenticate_user!
    user = session[:user].blank? ? nil : User.find_by(id: session[:user]['id'])
   
    if user && user.enabled && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, session[:token])
      @@current_user = user
    else
      notice = user.present? ? '您已被禁用' : '请登录'
      redirect_to login_path, notice: notice
    end
  end

  private

  def login(user)
    session[:user] = {id: user.id, name: user.name}
    session[:token]   = user.authentication_token

    user.last_sign_time = Time.now
    user.sign_times += 1
    user.save!(validate: false)
  end

  def logout
    session.delete(:user)
    @@current_user = nil
  end

  def login?
  	@@current_user.present?
  end

  def current_user
    @@current_user
  end

end