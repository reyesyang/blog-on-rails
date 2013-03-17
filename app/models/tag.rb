# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  default_scope :order => 'name'
  has_and_belongs_to_many :articles

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
