class AddColumnToReservations < ActiveRecord::Migration[5.1]
  def change
  	add_column :reservations, :paid, :boolean
  end
end
