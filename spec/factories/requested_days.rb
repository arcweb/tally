FactoryGirl.define do
  factory :requested_day do
    date_requested { Faker::Date.between(2.weeks.from_now, 4.months.from_now) }
    hours_requested 8
  end

end
