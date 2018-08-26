class Client::AboutController < Client::BaseController
	def index
		@about_me = Article.enabled.about_me.first
		@comments = @about_me.comments
	end
end