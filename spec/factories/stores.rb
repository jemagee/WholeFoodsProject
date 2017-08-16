FactoryGirl.define do
  factory :store do
    sequence(:name) {|n| "Store#{n}"}
    sequence(:number) {|n| n+1}
  end
end
