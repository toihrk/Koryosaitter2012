class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, :null => false
      t.string :icon, :null => false
      t.string :screenname, :null => false
      t.string :token, :null => false
      t.string :secret, :null => false
      t.timestamps
    end
    add_index :users, :uid, :unique => true
  end
end

