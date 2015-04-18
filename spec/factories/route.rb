FactoryGirl.define do
  factory :route do
    sequence(:name) {|n| "route-#{n}"}
  end

  trait :with_stops do
    after(:create) do |route, evaluator|
      rand(1..6).times do
        route.bus_stops << FactoryGirl.create(:bus_stop)
      end
    end
  end
end