class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.integer :likes, default: 0
      t.integer :user_id
      # t.integer :game_id
      t.integer :reply_id
      t.integer :comment_id
      t.timestamps
    end
  end
end
