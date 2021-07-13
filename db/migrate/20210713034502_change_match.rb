class ChangeMatch < ActiveRecord::Migration[6.1]
  def change
    change_column_null :matches, :first_innings_id, false
    change_column_null :matches, :second_innings_id, false
  end
end
