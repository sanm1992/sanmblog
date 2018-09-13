class Admin::UsersController < Admin::BaseController
	skip_before_action :authenticate_user!, only: [:reset_password]
	def index
		@users = User.all
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
			redirect_to(admin_user_path(@user), notice: "创建成功")
		else
			render :action => "new"
		end
	end

	private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end