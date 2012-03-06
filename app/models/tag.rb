# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  attr_accessible :name
  default_scope :order => 'name'
  has_and_belongs_to_many :articles

  def to_param
    "#{id}-#{name}"
  end
end
