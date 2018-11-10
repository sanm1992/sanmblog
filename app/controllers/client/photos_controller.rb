class Client::PhotosController < Client::BaseController
	def index
		@photos = Photo.enabled
	end
end