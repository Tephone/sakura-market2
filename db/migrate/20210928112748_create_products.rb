class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :image
      t.text :content, null: false, default: ''
      t.boolean :display, null: false, default: true
      t.references :seller, null: false, foreign_key: true
      t.integer :stock, null: false, default: 0

      t.timestamps
    end
  end
end
