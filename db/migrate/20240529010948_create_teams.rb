class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :fc
      t.string :league
      t.string :stadium
      t.string :logo_url
      t.timestamps
    end
  end
end
