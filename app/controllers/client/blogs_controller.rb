class Client::BlogsController < Client::BaseController
	def show
		id = params['id'].to_i
		articles = Article.tec_articles.where(id: [id-1, id, id+1]).group_by{|article| article.id}

		@previous = articles[id-1]&.first
		@article 	= articles[id]&.first
		@next    	= articles[id+1]&.first

		if @article.nil?
			redirect_to client_home_index_path
		end
		@comments = @article.comments
	end

	def by_tag
		articles = Article.by_tag params['tag']
		@page_no = params['page_no'] || 1
		@page_size = 1
		@count = articles.size
		@articles = articles.limit(@page_size.to_i).offset(@page_no.to_i-1)
	end
end