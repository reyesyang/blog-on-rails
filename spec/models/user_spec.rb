require 'spec_helper'

describe User do
  it 'is not admin when email is not eqaul to admin_email' do
    user = User.new "non_admin@gmail.com"
    expect(user).not_to be_admin
  end

  it 'is admin when email is eqaul to admin_email' do
    user = User.new APP_CONFIG[:admin_email]
    expect(user).to be_admin
  end
end
