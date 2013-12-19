require 'spec_helper'

describe User do
  subject(:user) { User.new APP_CONFIG[:admin_email] }

  it { should be_admin }

  it 'is not admin when email is not eqaul to admin_email' do
    user.email = "non_admin@gmail.com"
    expect(user).not_to be_admin
  end
end
