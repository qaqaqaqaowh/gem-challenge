task clean: :environment do
	counter = 0
	while counter == 0
#---------------------------------------------------------------------------------------------
		@reservations = Reservation.where("end_date < ? OR (paid = ? AND created_at <= ?)", Time.new, false, Time.new - (60*15))
#---------------------------------------------------------------------------------------------
		# @reservations = Reservation.all
#---------------------------------------------------------------------------------------------
		counter = @reservations.count
		p "Cleaned #{counter} reservations"
		p Time.new
		puts "----------------------------------"
		@reservations.destroy_all
		counter = 0
		sleep(1.minute)
	end
end