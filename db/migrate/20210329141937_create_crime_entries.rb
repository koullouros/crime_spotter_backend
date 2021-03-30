class CreateCrimeEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :crime_entries do |t|
      t.belongs_to :location, null: false, foreign_key: true
      t.string :name
      t.integer :value
      t.date :month

      t.timestamps
    end
  end
end
