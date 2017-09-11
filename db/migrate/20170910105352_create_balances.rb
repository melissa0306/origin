class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.references :user
      t.date :date
      t.decimal :emission, :precision => 8, :scale => 3
      t.decimal :track_length, :precision => 8, :scale => 3
      t.timestamps null: false
    end
  end
end
