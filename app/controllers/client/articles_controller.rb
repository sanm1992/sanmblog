class Client::ArticlesController < Client::BaseController
	def show
		id = params['id'].to_i
		@article = Article.enabled.tec_articles.find(params['id'])
		@comments = @article.comments

		@next    	= Article.next(params['id'])
		@previous = Article.previous(params['id'])

	end

	def by_tag
		articles = Article.enabled.by_tag params['tag']
		@page_no = params['page_no'] || 1
		@page_size = 10
		@count = articles.size
		@articles = articles.limit(@page_size.to_i).offset(@page_no.to_i-1)
	end
end