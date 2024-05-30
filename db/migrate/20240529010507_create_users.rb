class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string  :name
      t.string :username
      t.string  :password_digest
      t.string :email
      t.integer :coins, default: 1000
      t.string  :address
      t.string  :birth
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
