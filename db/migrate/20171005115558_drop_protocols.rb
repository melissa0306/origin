class DropProtocols < ActiveRecord::Migration
  def change
    drop_table :protocols
  end
end
