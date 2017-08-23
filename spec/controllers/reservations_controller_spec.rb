require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
	# describe "GET #index" do
	# 	it "returns success" do
	# 		get :index
	# 		expect(response).to have_http_status(:success)
	# 	end
	# end

	describe "POST #create" do
		let(:user) {User.create(email: "nicholasowh@hotmail.com", password: "qaqaqaqa")}
		let(:listing) {Listing.create(product_name: "hello", price: 100)}
		let(:params) {{starting_date: Date.new(1997, 7, 20), end_date: Date.new(1997, 11, 30) }}
		let(:invalid_params) {{starting_date: Date.new(1997, 7, 21), end_date: Date.new(1997, 11, 29)}}
		let(:freelisting) {Listing.create(product_name: "free", price: 0)}

		context "when valid params" do
			it "should save" do
				sign_in_as(user)
				listing.update(user_id: user.id)
				expect{post :create, params: {id: listing.id}.merge(params)}.to change(Reservation, :count).by(1)
				expect(response).to redirect_to braintree_new_path(Reservation.last.id)
			end

			it "redirect to user if price 0" do
				sign_in_as(user)
				freelisting.update(user_id: user.id)
				expect{post :create, params: {id: freelisting.id, starting_date: Date.new(1997,7,20), end_date: Date.new(1997,11,30)}}.to change(Reservation, :count).by(1)
				expect(response).to redirect_to user_path(user.id)
			end
		end

		context "when invalid params" do
			it "should not save" do
				sign_in_as(user)
				listing.update(user_id: user.id)
				listing.reservations.create(starting_date: Date.new(1997,7,20), end_date: Date.new(1997,11,30), user_id: user.id)
				expect{post :create, params: {id: listing.id}.merge(invalid_params)}.to change(Reservation, :count).by(0)
				expect(response).to render_template("new")
			end
		end
	end

	describe "GET #new" do
		let(:user) {User.create(email: "nicholasowh@hotmail.com", password: "qaqaqaqa")}
		let(:listing) {Listing.create(product_name: "hello", price: 100)}
		
		it "render new page" do
			sign_in_as(user)
			listing.update(user_id: user.id)
			get :new, params: {format: listing.id}
			expect(response).to render_template("new")
		end
	end
end