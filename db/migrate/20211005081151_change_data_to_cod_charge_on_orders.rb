class ChangeDataToCodChargeOnOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :cod_charge, :string
    add_column :orders, :cod_charge, :integer, null: false
  end
end
