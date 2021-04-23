class CreateSearches < ActiveRecord::Migration[6.1]
  # TODO: seeds and validation
  def change
    create_table :searches do |t|
      t.string :term

      t.timestamps
    end
  end
end
