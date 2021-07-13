class CreateInnings < ActiveRecord::Migration[6.1]
  def change
    create_table :innings do |t|
      t.references :deliveries, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :score, default: 0
      t.integer :wickets, default: 0
      t.references :strike_batsman, null: false, foreign_key: {to_table: :users }
      t.references :non_strike_batsman, null: false, foreign_key: {to_table: :users }
      t.references :bowler, null: false, foreign_key: {to_table: :users }
      t.boolean :in_progress

      t.timestamps
    end
  end
end
