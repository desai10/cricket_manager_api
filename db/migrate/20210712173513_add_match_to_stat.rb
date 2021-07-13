class AddMatchToStat < ActiveRecord::Migration[6.1]
  def change
    add_reference :stats, :match, null: false, foreign_key: true
  end
end
