class AddVisibleToProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :display, :boolean
    add_column :products, :visible, :boolean, default: true
  end
end
