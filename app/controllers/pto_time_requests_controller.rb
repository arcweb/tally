class PtoTimeRequestsController < ApplicationController
  def approve
    TimeRequest.find(params[:id]).approve
    redirect_to :back
  end

  def deny
    TimeRequest.find(params[:id]).deny
    redirect_to :back
  end
end
