class Article < ActiveRecord::Base
	validates :title, :summary, :content, :presence=> true
	validates :title,	:uniqueness => true

	has_many :comments, :dependent => :destroy
	has_many :tags
	
	accepts_nested_attributes_for :tags, :allow_destroy => :true,
		:reject_if => proc { |attrs| attrs.all? { |k, v| v.blank?} }
end