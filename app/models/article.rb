# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  
  validates :title, :content, :presence => true
  validates :title, uniqueness: true
  validates :content, length: { minimum: 20 }

  self.per_page = 10

  def tag_list=(value)
    tags = value.split(',').map { |tag| tag.strip.downcase }.reject { |t| t.blank? }

    self.tags = if tags.include?('draft')
                  [Tag.find_or_create_by(name: 'draft')]
                else
                  tags.map{ |tag| Tag.find_or_create_by(name: tag) }
                end
  end

  def tag_list
    self.tags.map(&:name).join(', ')
  end

  def draft?
    tags.where(name: 'draft').any?
  end
end
