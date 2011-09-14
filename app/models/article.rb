class Article < ActiveRecord::Base
  validates :title, :summary, :content, :presence => true

  has_many :comments, :dependent => :destroy
# has_and_belongs_to_many :tags
	has_many :taggings, :dependent => :destroy
	has_many :tags, :through => :taggings

#  accepts_nested_attributes_for :tags, :allow_destroy => :true,
#    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
	
	attr_accessor :tag_names
	after_save :assign_tags

	private
	def assign_tags
		if @tag_names
			self.tags = @tag_names.split(';').map do |name|
				Tag.find_or_create_by_name(name)
			end
		end
	end

	def tag_names
		@tag_names || tags.map(&:name).join(';')
	end
end
