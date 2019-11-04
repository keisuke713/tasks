FactoryBot.define do
  factory :task do
    title  "MyTask"
    detail "MyString"
    deadline "2019-10-23"
    status 0 
    label nil
  end
end
