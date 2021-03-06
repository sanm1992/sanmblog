class Admin::SessionsController < Admin::BaseController
	layout 'application'
	skip_before_action :authenticate_user!, only: [:new, :create]

	def new
	end

	def create
		email 		= params[:session][:email]
		password 	= params[:session][:password]

		user = User.find_by(email: email)

		if user && user.enabled && user.authenticate(password)
			login(user)
			redirect_to admin_root_path, notice: '登录成功'
		else
			notice = user.presence.nil? ? '您已被禁用' : '密码或邮箱错误'

			redirect_back(fallback_location: login_path, notice: notice)
		end
	end

	def destroy
		logout if login?
		redirect_to login_path, notice: '已退出登录'
	end

end