FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "testuser#{i}" }
    sequence(:email) { |i| "testuser#{i}@example.com" }
    sequence(:password) { |i| "testuser#{i}" }
  end
end
