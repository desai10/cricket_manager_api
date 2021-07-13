class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.integer :runs_scored, default: 0
      t.integer :balls_faced, default: 0
      t.integer :runs_given, default: 0
      t.integer :balls_bowled, default: 0
      t.integer :wickets_taken, default: 0
      t.integer :fours, default: 0
      t.integer :sixes, default: 0
      t.integer :catches, default: 0
      t.integer :run_outs, default: 0
      t.integer :batting_order, default: 100
      t.integer :bowling_order, default: 100

      t.timestamps
    end
  end
end
