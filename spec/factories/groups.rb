FactoryGirl.define do
  factory :group do
    sequence(:name) { |i| "testgroup#{i}" }
  end
end

