class Tag < ActiveRecord::Base
  default_scope :order => 'name'
#	has_and_belongs_to_many :articles
	has_many :taggings, :dependent => :destroy
	has_many :articles, :through => :taggings
end
