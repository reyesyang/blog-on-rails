require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "validation" do
    assert Factory.build(:user, :name => '').invalid?
    assert Factory.build(:user, :password => '', :password_confirmation => '').invalid?
    assert Factory.build(:user, :password => 'password', :password_confirmation => nil).invalid?
    assert Factory.build(:user, :password => 'password', :password_confirmation => 'notmatch').invalid?
    assert Factory.build(:user).valid?
  end
end
