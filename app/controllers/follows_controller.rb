class FollowsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find_by_username!(params[:profile_username])

    current_user.follow(@user) if current_user.id != @user.id

    render json: { following: current_user.following?(@user) }
  end

  def destroy
    @user = User.find_by_username!(params[:profile_username])

    current_user.stop_following(@user) if current_user.id != @user.id

    render json: { following: current_user.following?(@user) }
  end
end
