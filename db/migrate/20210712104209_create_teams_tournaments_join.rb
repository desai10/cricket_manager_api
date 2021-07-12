class CreateTeamsTournamentsJoin < ActiveRecord::Migration[6.1]
  def up
    create_table :teams_tournaments, :id => false do |t|

      t.integer "tournament_id"
      t.integer "team_id"

      t.timestamps
    end
    
    add_index("teams_tournaments", ["tournament_id", "team_id"])
  end

  def down
    drop_table :teams_tournaments
  end
end
