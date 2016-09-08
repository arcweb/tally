class CancelPtoTimeRequestsController < ApplicationController
  respond_to :js

  def create
    day_to_cancel = VacationDay.find(params[:vacation_day_id])
    if current_user.admin?
      day_to_cancel.destroy
      render json: {status: :ok,
                    type: "CancelPtoTimeRequest",
                    vacation_day_id: params[:vacation_day_id]}
    else
      raw_request = { 
        user: current_user,
        type: 'CancelPtoTimeRequest',
        requested_days_attributes:[ {
                                      date_requested: day_to_cancel.date_requested,
                                      hours_requested: day_to_cancel.requested_day.hours_requested
                                    } ]
      }
      CancelPtoTimeRequest.create_and_notify(raw_request)
      render json: {status: :ok}
    end
   
  end
end
