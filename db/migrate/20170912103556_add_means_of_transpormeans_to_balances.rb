class AddMeansOfTranspormeansToBalances < ActiveRecord::Migration
  def change
    add_column :balances, :means_of_transport, :string
  end
end
