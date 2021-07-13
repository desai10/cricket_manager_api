class AddUserToStat < ActiveRecord::Migration[6.1]
  def change
    add_reference :stats, :user, null: false, foreign_key: true
  end
end
