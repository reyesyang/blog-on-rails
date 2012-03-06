# -*- encoding : utf-8 -*-
require 'digest/sha2'

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :password, :password_confirmation

  validates :name, :presence => true, :uniqueness => true
  validates :password_confirmation, :presence => true, :on => :create
 end
