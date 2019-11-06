FactoryBot.define do
  factory :task do
    title  "MyTask"
    detail "MyString"
    deadline Date.today
    status 0 
    label :work
  end
end
