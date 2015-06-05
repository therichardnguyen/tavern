FactoryGirl.define do
  factory :user do
    email {Faker::Internet.free_email}
    password_digest { Faker::Bitcoin.address }
  end
end