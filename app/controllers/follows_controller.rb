class FollowsController < ApplicationController
  before_action :authenticate_user

  def create 
    @follow = Follow.new(
      user_id: @current_user.id,
      followed_id: params[:id]
    )
    @follow.save
    redirect_to("/users/#{params[:id]}")
  end
  
  def destroy
    @follow = Follow.find_by(
      user_id: @current_user.id,
      followed_id: params[:id]
    )
    @follow.destroy
    redirect_to("/users/#{params[:id]}")
  end

end