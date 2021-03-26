class CreateCrimeTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :crime_types do |t|
      t.string :crime_name

      t.timestamps
    end
  end
end
