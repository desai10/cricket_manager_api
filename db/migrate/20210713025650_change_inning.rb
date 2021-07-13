class ChangeInning < ActiveRecord::Migration[6.1]
  def change
    remove_column :innings, :deliveries_id
    change_column_null :innings, :strike_batsman_id, false
    change_column_null :innings, :non_strike_batsman_id, false
    change_column_null :innings, :bowler_id, false
    change_column :innings, :in_progress, :boolean, default: false
  end
end
