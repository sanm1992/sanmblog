class Article < ApplicationRecord
	has_many :comments

	scope :about_me, -> { where(category: 'about_me') }
	scope :tec_articles, -> {where(category: 'tec')}
	scope :enabled, -> {where(enabled: true)}
	scope :by_tag, -> (tag){where(tag: tag)}

	validates :type, presence: true
	validates :title, presence: true
	validates :content, presence: true


	class << self
		def archives
			articles = Article.enabled.tec_articles.select('title, created_at ,id').as_json
			count = articles.size
			articles = articles.group_by{|article| article['created_at'].year}
			{"count" => count, "articles" => articles}
		end

	end
end