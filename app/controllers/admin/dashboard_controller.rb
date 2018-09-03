class Admin::DashboardController < Admin::BaseController
	def index
		p '1111111111111',request.remote_ip
		p '===========', request.ip()
	end
end