class Client::ArchivesController < Client::BaseController
	def index
		@archives = Article.archives
	end
end