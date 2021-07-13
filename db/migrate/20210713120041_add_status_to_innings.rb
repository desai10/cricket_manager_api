class AddStatusToInnings < ActiveRecord::Migration[6.1]
  def change
    add_column :innings, :status, :string, default: 'NOT STARTED'
  end
end
