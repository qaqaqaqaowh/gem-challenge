class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :listing_id
      t.date :starting_date
      t.date :end_date

      t.timestamps
    end
  end
end
