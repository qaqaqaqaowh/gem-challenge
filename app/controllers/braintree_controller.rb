class BraintreeController < ApplicationController
  def new
  	@client_token = Braintree::ClientToken.generate
  	@reservation = Reservation.find(params[:format])
  end

  def checkout
	  @reservation = Reservation.find(params[:id])
	  @price = (@reservation.starting_date..@reservation.end_date).count * @reservation.listing.price
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => @price,
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	  	@reservation.update(paid: true)
	    redirect_to current_user, :flash => { :success => "Transaction successful!" }
	  else
	  	@reservation.destroy
	    redirect_to listings_path, :flash => { :error => "Transaction failed. Please try again." }
	  end 
	end
end
