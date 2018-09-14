module LoginHelper
	def login?
		current_user.present?
	end

	def current_user
		session[:user]
	end
end