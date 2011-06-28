class Comment < ActiveRecord::Base
	validates :commenter, :content, :presence => true
	belongs_to :article
end
