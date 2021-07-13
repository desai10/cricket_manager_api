class AddExtraToDelivery < ActiveRecord::Migration[6.1]
  def change
    add_column :deliveries, :extra, :string
  end
end
