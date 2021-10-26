class AddColumnsUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nickname, :string, null: false, default: ''
    add_column :users, :image, :text
  end
end
