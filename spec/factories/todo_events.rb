# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :todo_event do
    event "MyString"
    description "MyText"
    date "2015-11-25 00:49:52"
    user nil
  end
end
