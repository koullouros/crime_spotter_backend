class AddMonthToCrimeEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :crime_entries, :month, :date
  end
end
