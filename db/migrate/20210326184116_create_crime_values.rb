class CreateCrimeValues < ActiveRecord::Migration[6.1]
  def change
    create_table :crime_values do |t|
      t.integer :crime_value
      
      t.timestamps
    end
  end
end
