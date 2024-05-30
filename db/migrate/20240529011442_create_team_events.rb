class CreateTeamEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :team_events do |t|
      t.integer :team_id
      t.integer :game_id
      t.integer :points, default: 0
      t.timestamps
    end
  end
end
