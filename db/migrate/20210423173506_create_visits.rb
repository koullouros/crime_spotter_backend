class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    # TODO: seeds and validation
    create_table :visits do |t|
      t.string :ip_address

      t.timestamps
    end
  end
end
