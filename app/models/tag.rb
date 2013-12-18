# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :articles, through: :taggings

  scope :ordered, -> { order('name') }

  def to_param
    name
  end

  def self.list(user)
    if user && user.admin?
      Tag.all
    else
      Tag.where("name != 'draft'").all
    end
  end
end
