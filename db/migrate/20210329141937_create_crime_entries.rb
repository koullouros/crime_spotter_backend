class CreateCrimeEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :crime_entries do |t|
      t.belongs_to :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
