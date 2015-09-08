# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
  	association :user
    title "MyString"
    content "MyText"
    user nil
  end
end
