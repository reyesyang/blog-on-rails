# -*- encoding : utf-8 -*-
require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :name, :email, :image_url
  has_many :authorizations

  validates :name, :presence => true
 end
