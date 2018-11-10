class Photo < ApplicationRecord
	validates :oss_url, presence: true
	
	scope :enabled, ->{where(enabled: true)}
end