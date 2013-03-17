# -*- encoding : utf-8 -*-
require 'digest/sha2'

class User < ActiveRecord::Base
  has_many :authorizations

  validates :name, :email, :presence => true

  def admin?
    email == APP_CONFIG['admin_email']
  end
end
