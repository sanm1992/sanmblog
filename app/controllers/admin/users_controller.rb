class Admin::UsersController < Admin::BaseController
	skip_before_action :authenticate_user!, only: [:reset_password]
	def index
		page = params[:page] || 1
		@users = User.page(page.to_i).per(20)
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new user_params
		if @user.save
			redirect_to admin_user_path(@user), notice: "创建成功"
		else
			render :action => "new"
		end
	end

	def destroy
		user = User.find_by(id: params[:id])
		user.enabled = false

		notice = user.save(validate: false) ? '禁用成功' : '禁用失败'
		
		redirect_to(admin_users_path, notice: notice)
	end

	def set_enabled
		user = User.find_by(id: params[:id])
  	user.enabled = true

  	notice = user.save(validate: false) ? '启用成功' : '启用失败'

		redirect_to admin_users_path, notice: notice
	end

	def reset_password
		user = User.find_by(email: params[:user][:email])
		if user.blank?
			redirect_to login_path, notice: '该账户不存在,请先注册'
		else
			user.password = params[:user][:password]
			user.password_confirmation = params[:user][:password]
			
			if user.save
				redirect_to login_path, notice: '重置成功请登录'
			else
				redirect_back(fallback_location: login_path, notice: '重置密码失败')
			end
			
		end
	end


	private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end