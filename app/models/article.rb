class Article < ActiveRecord::Base
	validates :title, :tags, :summary, :content, :presence=> true
	validates :title,	:uniqueness => true

	has_many :comments
end
