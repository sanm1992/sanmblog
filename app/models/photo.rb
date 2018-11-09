class Photo < ApplicationRecord
	validates :oss_url, presence: true
	
end