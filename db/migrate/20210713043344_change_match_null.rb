class ChangeMatchNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :matches, :first_innings_id, true
    change_column_null :matches, :second_innings_id, true
    change_column_null :innings, :strike_batsman_id, true
    change_column_null :innings, :non_strike_batsman_id, true
    change_column_null :innings, :bowler_id, true
  end
end
