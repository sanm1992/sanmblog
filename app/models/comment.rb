class Comment < ApplicationRecord
	belongs_to :article

	scope :personal_letter, -> {joins(:article).where(articles: {category: 'about_me'})}
	scope :enabled, -> {where(enabled: true)}

	validates :user_name, presence: true
	validates :email, presence: true
	validates :content, presence: true

end