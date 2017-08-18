class UsersController < ApplicationController
  def show
  	@reservations = current_user.reservations
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if params[:user][:avatar]
      @user.avatar = params[:user][:avatar]
    end
  	@user.save
    ReservationMailer.spam_email(@user).deliver_now
    format.html { redirect_to(@user, notice: 'User was successfully created.') }
    format.json { render json: @user, status: :created, location: @user }
    redirect_to current_user
  end
end
