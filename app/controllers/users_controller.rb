class UsersController < ApplicationController
  def show
  	@reservations = current_user.reservations
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.avatar = params[:user][:avatar]
  	@user.save
  	redirect_to current_user
  end
end
