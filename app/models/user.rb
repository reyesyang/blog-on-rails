# -*- encoding : utf-8 -*-
class User
  attr_accessor :email

  def initialize(email)
    @email = email
  end

  def admin?
    email == APP_CONFIG['admin_email']
  end
end
