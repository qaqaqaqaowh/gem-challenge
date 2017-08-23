class Reservation < ApplicationRecord
	belongs_to :listing
	belongs_to :user
	validates :end_date, :starting_date, presence: true
	validate :overlap, on: :create

	def overlap
		reservations = Reservation.where(listing_id: listing_id)
		reservations.each{|r|
			if starting_date >= r.starting_date && end_date <= r.end_date
				errors.add(:date ,"Date has been booked")
				break
			end
		}
	end
end
