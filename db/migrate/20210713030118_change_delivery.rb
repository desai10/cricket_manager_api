class ChangeDelivery < ActiveRecord::Migration[6.1]
  def change
    add_reference :deliveries, :inning, foreign_key: true
  end
end
