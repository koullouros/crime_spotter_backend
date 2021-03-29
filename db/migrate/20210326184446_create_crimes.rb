class CreateCrimes < ActiveRecord::Migration[6.1]
  def change
    create_table :crimes do |t|
      t.has_one :location
      t.has_many :crime_types
      t.has_many :crime_values

      t.timestamps
    end
  end
end
