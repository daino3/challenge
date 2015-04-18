FactoryGirl.define do
  factory :street do
    sequence(:name) { |n| "street-#{n}"}
  end
end