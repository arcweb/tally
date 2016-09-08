class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  respond_to :js, only: :update

  def index
    @users = User.all
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : current_user
    @users = User.all if current_user.admin?
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params[:user])

    render json: { status: :ok }
  end

  def destroy 
    @user = User.find(params[:id])
    @user.archive

    redirect_to :users
  end

private
  def user_params
    params.permit(
      user: [
        :total_pto,
        :carryover_pto,
        :bonus_pto
      ]
    )
  end
end
