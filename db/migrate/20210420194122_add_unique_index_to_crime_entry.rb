class AddUniqueIndexToCrimeEntry < ActiveRecord::Migration[6.1]
  def change
    add_index :crime_entries, [:location_id, :name, :month], unique: true
  end
end
