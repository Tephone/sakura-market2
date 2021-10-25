class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.text :content, null: false
      t.text :image
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false

      t.timestamps
    end
  end
end
