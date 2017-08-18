class ListingTag < ActiveRecord::Migration[5.1]
  def change
  	create_table :listings_tags do |t|
      t.references :listing
      t.integer :tag_id

      t.timestamps
 	end
  end
end