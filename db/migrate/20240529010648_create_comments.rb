class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :likes
      t.integer :game_id
      t.integer :user_id
      t.string :comment
      t.timestamps
    end
  end
end
