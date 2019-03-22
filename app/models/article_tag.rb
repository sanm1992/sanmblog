class ArticleTag < ApplicationRecord
	self.table_name = 'article_tags'
	validates :name, presence: true
	validates :code, presence: true

	scope :enabled , -> {where(enabled: true)}

	class << self
		def for_select
			self.enabled.pluck(:name, :code)
		end
	end
end
