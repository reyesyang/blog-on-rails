# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  attr_accessible :title, :content, :tags_string
  before_save :update_articles_count_on_tags_bf_save
  before_destroy :update_articles_count_on_tags_bf_destroy

  validates :title, :content, :presence => true

  has_and_belongs_to_many :tags
  
  self.per_page = 10
  @@original_tags = nil

  def tags_string=(value)
    @@original_tags = self.tags.clone

    self.tags = value.split(';').map do |name|
      Tag.find_or_create_by_name(name.strip)
    end
  end

  def tags_string
    self.tags.map(&:name).join('; ')
  end

  private
  def update_articles_count_on_tags_bf_save
    added_tags = []
    removed_tags = []

    if id
      added_tags = self.tags - @@original_tags
      removed_tags = @@original_tags - self.tags
    else
      added_tags = self.tags
    end
    
    increment_articles_count_on_tags(added_tags) if added_tags
    decrement_articles_count_on_tags(removed_tags) if removed_tags
  end
 
  def update_articles_count_on_tags_bf_destroy
    decrement_articles_count_on_tags(self.tags)
  end

  def increment_articles_count_on_tags(tags)
    tags.each do |tag|
      tag.update_attribute(:articles_count, tag.articles_count + 1)
    end
  end

  def decrement_articles_count_on_tags(tags)
    tags.each do |tag|
      articles_count = tag.articles.count - 1;

      if articles_count > 0
        tag.update_attribute(:articles_count, articles_count)
      else
        tag.destroy
      end
    end
  end
end
