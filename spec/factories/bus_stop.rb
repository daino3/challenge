FactoryGirl.define do
  factory :bus_stop do
    association :street, factory: :street
    association :cross_street, factory: :street
    latitude 81.12345
    longitude 42.12345
    boardings (1..100).to_a.sample
    alightings (1..100).to_a.sample
    daytype "Weekday"
    month_beginning Time.now.to_date
  end
end