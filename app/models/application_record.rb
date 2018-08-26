class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def next
  	self.class.find_by(id: self.id+1)
  end

  def previous
  	self.class.find_by(id: self.id-1)
  end

  def page(page_no, page_size)
  	self.limit(page_size.to_i).offset(page_no.to_i)
  end
end
