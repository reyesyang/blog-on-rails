class Article < ActiveRecord::Base
	validates :title, :summary, :content, :presence=> true
	validates :title,	:uniqueness => true

	has_many :comments
end
