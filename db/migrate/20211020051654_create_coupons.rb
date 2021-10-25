class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.integer :point,null: false

      t.timestamps
    end
    add_index :coupons, :point
    add_index :coupons, %i[code point], unique: true
  end
end
