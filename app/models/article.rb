class Article < ActiveRecord::Base
  after_create :increment_articles_count_on_tags
  before_destroy :decrement_articles_count_on_tags

  validates :title, :content, :presence => true
  validates :english_title, :uniqueness => true

  has_and_belongs_to_many :tags

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

  private
  def increment_articles_count_on_tags
    self.tags.each do |tag| 
      tag.update_attribute(:articles_count, tag.articles_count + 1)
    end
  end
 
  def decrement_articles_count_on_tags
    puts '*' * 20
    self.tags.each do |tag|
      articles_count = tag.articles.count - 1;
      puts articles_count

      if articles_count > 0
        tag.update_attribute(:articles_count, articles_count)
        puts '*' * 20
        puts tag.inspect
      else
        tag.destroy
      end
    end
  end
end
