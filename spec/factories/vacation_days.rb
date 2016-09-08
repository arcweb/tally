FactoryGirl.define do
  factory :vacation_day do
    transient do
      date_taken {Faker::Date.between(2.months.ago, 2.months.from_now)}
    end
    user
    time_request
    requested_day {create :requested_day,  date_requested: date_taken}
  end
end
