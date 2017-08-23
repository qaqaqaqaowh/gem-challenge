require 'rails_helper'

RSpec.describe Reservation, type: :model do
	let(:valid_start_date) {Date.new(1997, 7, 20)}
	let(:valid_end_date) {Date.new(1997, 11, 30)}
	let(:invalid_start_date) {Date.new(1997, 7, 21)}
	let(:invalid_end_date) {Date.new(1997, 11, 29)}

	context "Validation: " do
		it { is_expected.to validate_presence_of(:starting_date) }
		it { is_expected.to validate_presence_of(:end_date) }
	end

	context "Functions: " do	
		it "check for overlapping dates" do
			user = User.create(email: "nicholasowh@hotmail.com", password: "qaqaqaqa") 
			listing = Listing.create(user_id: user.id, product_name: "hello", price: 100)
			Reservation.create(user_id: user.id, listing_id: listing.id, starting_date: valid_start_date, end_date: valid_end_date)
			expect( Reservation.find_by(starting_date: valid_start_date) ).not_to eq nil
			Reservation.create(user_id: user.id, listing_id: listing.id, starting_date: invalid_start_date, end_date: invalid_end_date)
			expect( Reservation.find_by(starting_date: invalid_start_date) ).to eq nil
		end

		it "takes in only two dates" do
			user = User.create(email: "nicholasowh@hotmail.com", password: "qaqaqaqa") 
			listing = Listing.create(user_id: user.id, product_name: "hello", price: 100)
			Reservation.create(user_id: user.id, listing_id: listing.id, starting_date: valid_start_date)
			expect( Reservation.find_by(starting_date: valid_start_date) ).to eq nil
			Reservation.create(user_id: user.id, listing_id: listing.id, end_date: valid_end_date)
			expect( Reservation.find_by(end_date: valid_end_date) ).to eq nil
		end
	end
end