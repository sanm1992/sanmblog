class Client::HomeController < Client::BaseController
	def index
		@page_no = params['page_no'] || 1
		@page_size = 10
		articles = Article.enabled.tec_articles.order(:created_at)
		@count = articles.size
		@articles = articles.limit(@page_size.to_i).offset(@page_no.to_i-1)
	end
end