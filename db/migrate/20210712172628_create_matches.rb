class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :home_team, null: false, foreign_key: {to_table: :users}
      t.references :away_team, null: false, foreign_key: {to_table: :users}
      t.string :toss
      t.string :toss_decision
      t.integer :overs, default: 6
      t.boolean :single_batsman_allowed, default: true

      t.timestamps
    end
  end
end
