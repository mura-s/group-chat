FactoryGirl.define do
  factory :message do
    sequence(:content) { |i| "testcontent#{i}" }
  end
end


