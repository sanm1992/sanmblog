class Admin::SessionsController < Admin::BaseController
	layout 'application'
	skip_before_action :authenticate_user!, only: [:new, :create]

	def new
	end

	def create
		email 		= params[:session][:email]
		password 	= params[:session][:password]

		user = User.find_by(email: email)

		if user && user.authenticate(password)
			login(user)
			redirect_to admin_root_path, notice: '登录成功'
		else
			redirect_back(fallback_location: login_path, notice: "密码或邮箱错误")
		end
	end

	def destroy
		logout if login?
		redirect_to login_path, notice: '已退出登录'
	end

	private

	def login(user)
		session[:user_id] = user.id
		session[:token]   = user.authentication_token

		user.last_sign_time = Time.now
		user.sign_times += 1
		user.save!(validate: false)
	end

	def logout
		session.delete(:user_id)
    @current_user = nil
	end

end