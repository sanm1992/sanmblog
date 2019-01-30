class Client::HomeController < Client::BaseController
	def index
		@page_no = params['page_no'] || 1
		@page_size = 10
		articles = Article.enabled.tec_articles.order(created_at: :desc)
		@count = articles.size
		@articles = articles.limit(@page_size.to_i).offset(@page_no.to_i-1)
		
		# news = $redis.get(:news)
		# if news.blank?
		# 	news = Article.enabled.tec_articles.news.select(%w[id title created_at]).as_json
		# 	$redis.set(:news, news.to_json)
		# end

		# @news = news.is_a?(String) ? JSON.parse(news) : news
	end
end