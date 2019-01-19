class Photo < ApplicationRecord
	validates :oss_url, presence: true
	
	scope :enabled, ->{where(enabled: true)}

	class << self
		def calendar(dev=0)
			tdate = Time.now
			ddate = tdate + (dev).month
			
			my_year = ddate.year
			my_month = ddate.month
			my_day = ddate.day

			begin_date = ddate.beginning_of_month
			end_date = ddate.end_of_month

			begin_day = begin_date.day
			end_day  = end_date.day

			days = []
			week = 1
			(begin_day..end_day).each do |i|
				day_map = {}
				_dev = i - 1
				_date = begin_date + _dev.day
				day_map['day']  = i
				day_map['wday'] = _date.wday

				week += 1 if _date.wday.zero?
				day_map['week'] = week
				days << day_map
			end
			days.group_by {|day| day['week']}
		end
	end
end