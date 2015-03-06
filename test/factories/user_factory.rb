FactoryGirl.define do

  factory :user1, class: User do
    id {Faker::Number.digit}
    name {Faker::Name.first_name}
    password_digest {Faker::Lorem.word}
  end
end
