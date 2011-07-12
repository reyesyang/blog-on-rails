class Tag < ActiveRecord::Base
  default_scope :order => 'name'
	has_and_belongs_to_many :articles
end
