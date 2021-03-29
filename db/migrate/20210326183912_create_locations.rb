class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.date :last_update


      t.timestamps
    end
  end
end
