class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :number, null: false
      t.references :bowler, null: false, foreign_key: {to_table: :users}
      t.references :batsman, null: false, foreign_key: {to_table: :users}
      t.references :helped_by, foreign_key: {to_table: :users}
      t.string :action, null: false

      t.timestamps
    end
  end
end
