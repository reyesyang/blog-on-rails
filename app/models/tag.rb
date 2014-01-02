# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :articles, through: :taggings

  scope :ordered, -> { order('name') }

  def to_param
    name
  end

  def draft?
    name == 'draft'
  end
end
