class Article < ApplicationRecord
	has_many :comments

	scope :about_me, -> { where(category: 'about_me')}
	scope :tec_articles, -> {where(category: 'tec')}
	scope :enabled, -> {where(enabled: true)}
	scope :by_tag, -> (tag){where(tag: tag)}
	scope :news, -> {order(created_at: :desc).limit(5)}

	validates :title, presence: true
	validates :content, presence: true

	after_create do 
		$redis.del(:news) if self.is_tec?
	end

	def is_tec?
		category == 'tec'
	end

	def html_content
		MyMarkdown.render_markdown(self.content)
	end

	class << self
		def archives
			articles = Article.enabled.tec_articles.order(created_at: :desc).select('title, created_at ,id').as_json
			count = articles.size
			articles = articles.group_by{|article| article['created_at'].year}
			{"count" => count, "articles" => articles}
		end

		def next(this_id)
			Article.enabled.tec_articles.where("id > ?", this_id).order(id: :asc).first
		end

		def previous(this_id)
			Article.enabled.tec_articles.where("id < ?", this_id).order(id: :desc).first
		end

	end
end