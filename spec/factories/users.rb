FactoryBot.define do
  factory :user do
    email 'test@example.com'
    password 'f43p455w0rd'
    initialize_with { User.find_or_create_by(email: email)}
  end
  factory :user2, class: User do
    email 'test2@example.com'
    password 'f33p455w0rd'
    initialize_with { User.find_or_create_by(email: email)}
  end
end
