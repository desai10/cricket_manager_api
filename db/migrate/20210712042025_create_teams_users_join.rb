class CreateTeamsUsersJoin < ActiveRecord::Migration[6.1]
  def up
    create_table :teams_users, :id => false do |t|

      t.integer "team_id"
      t.integer "user_id"

      t.timestamps
    end
    
    add_index("teams_users", ["team_id", "user_id"])
  end

  def down
    delete_table :teams_users
  end
end
