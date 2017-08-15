FactoryGirl.define do
  factory :region do
    sequence(:name) {|n| "Region Name#{n}"}
  end
end
