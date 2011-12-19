# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "name#{n}"}
    password 'password'
    password_confirmation 'password'
  end
end
