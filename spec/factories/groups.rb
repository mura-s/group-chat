FactoryGirl.define do
  factory :group do
    sequence(:name) { |i| "testgroup#{i}" }

    factory :group_with_user_and_messages do
      after(:create) do |group|
        user = create(:user, groups: [group])
        3.times { create(:message, user_id: user.id, group_id: group.id) }
      end
    end

    factory :invalid_group do
      name nil
    end
  end
end

