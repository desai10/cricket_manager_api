class AddInningsToMatch < ActiveRecord::Migration[6.1]
  def change
    add_reference :matches, :first_innings, null: false, foreign_key: { to_table: :innings }
    add_reference :matches, :second_innings, null: false, foreign_key: {to_table: :innings }
  end
end
