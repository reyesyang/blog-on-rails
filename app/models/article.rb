class Article < ActiveRecord::Base
  validates :title, :content, :presence => true
  validates :english_title, :uniqueness => true

  has_and_belongs_to_many :tags
  has_many :comments, :dependent => :destroy

  attr_accessible :title, :content, :tags_string, :english_title

  def tags_string=(value)
    self.tags = value.split(';').map do |name|
      Tag.find_or_create_by_name(name.strip)
    end
  end

  def tags_string
    self.tags.map(&:name).join('; ')
  end

  def to_param
    "#{id}-#{english_title.parameterize}"
  end
end
