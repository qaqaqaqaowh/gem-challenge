class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
		@listing ||= Listing.find(params[:format])
	end

	def create
		@listing = Listing.find(params[:id])
		@reservation = @listing.reservations.new(user_id: current_user.id,starting_date: params[:starting_date],end_date: params[:end_date])
		if @reservation.save
			if @listing.price == 0
				@reservation.update(paid: true)
				redirect_to current_user
			else
				redirect_to braintree_new_path(@reservation.id)
			end
		else
			flash[:notice]= @reservation.errors.full_messages.join(" ")
			render 'new'
		end
	end
end
