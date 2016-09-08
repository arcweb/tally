class TimeRequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  respond_to :js

  def create
    TimeRequest.create_and_notify(format_time_request_params)

    render json: { status: :ok }
  end

  def clear
    TimeRequest.find(params[:id]).cleared!

    render json: { status: :ok }
  end

  def pending
    render json: TimeRequest.pending
  end 

private
  def time_request_params
    params.permit(
      requested_days: [:date_requested, :hours_requested], 
      time_request: [:reason, :type, 
        requested_days_attributes: [:date_requested, :hours_requested]
      ]
    )
  end 

  def format_time_request_params
    request = time_request_params[:time_request].to_h
    request[:user] = current_user
    request[:requested_days_attributes] = 
      time_request_params[:requested_days].map do |key, day_params|
        {
          date_requested: day_params["date_requested"],
          hours_requested: day_params["hours_requested"]
        }
      end
    request
  end
end
