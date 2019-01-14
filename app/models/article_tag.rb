class ArticleTag < ApplicationRecord
	self.table_name = 'article_tags'
	validates :name, presence: true
	validates :code, presence: true
end
