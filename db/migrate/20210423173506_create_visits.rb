class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    # TODO: seeds and validation
    create_table :visits do |t|
      t.string :page
      t.string :ip_address
      t.string :location

      t.timestamps
    end
  end
end
