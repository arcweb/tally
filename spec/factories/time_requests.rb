FactoryGirl.define do
  factory :time_request do
    status            TimeRequest.statuses[:pending]
    type              "VacationRequest"
    user
  end

  factory :pto_time_request, parent: :time_request, class: PtoTimeRequest do
    transient do
      num_days 1
    end

    type "PtoTimeRequest"
    requested_days  { build_list :requested_day, num_days }
  end

  factory :cancel_pto_time_request, parent: :pto_time_request, class: CancelPtoTimeRequest
end
