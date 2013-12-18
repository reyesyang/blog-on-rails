# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "artile title #{n}" }
    content { 'a' * 20 }
    tag_list 'tag1,tag2'
  end
end
