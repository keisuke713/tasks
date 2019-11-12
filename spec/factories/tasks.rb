FactoryBot.define do
  factory :task do
    title  "MyTask"
    detail "MyString"
    deadline Date.today
    status 0 
    label :work
    user
  end
  factory :task_user_2_creating, class: Task do
    title  "MyTaskByUser2"
    detail "MyString"
    deadline Date.today
    status 0 
    label :work
    association :user, factory: :user2 
  end
end
