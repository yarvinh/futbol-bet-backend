class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.integer :team_id
      t.integer :league_id
      t.timestamps
    end
  end
end
