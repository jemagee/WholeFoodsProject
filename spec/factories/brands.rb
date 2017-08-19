FactoryGirl.define do
  factory :brand do
    sequence(:name) {|n| "Brand#{n}"}
    sequence(:prefix) {|n| 99999 + n}
  end
end
