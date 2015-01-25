FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "testuser#{i}" }
    sequence(:email) { |i| "testuser#{i}@example.com" }
    sequence(:password) { |i| "testuser#{i}" }

    factory :user_with_group do
      after(:create) do |user|
        create(:group, users: [user])
      end
    end
  end
end
