class CreateDeliveryTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_times do |t|
      t.integer :start_time, null: false
      t.integer :end_time, null: false

      t.timestamps
    end
    add_index :delivery_times, :end_time
    add_index :delivery_times, %i[start_time end_time], unique: true
  end
end
