class AddUsernameToUsers < ActiveRecord::Migration
  def change
  add_column :users, :username, :string # zu Users wird der String Username hinzugefügr
  add_index :users, :username, unique:true # jeden Username gibt es nur einmal
  end
end
