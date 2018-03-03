class CreateLendings < ActiveRecord::Migration[5.1]
  def change
    create_table :lendings do |t|
      t.integer :user_id, null:false
      t.integer :item_id, null:false
      t.date :dead_line, null:false
      t.boolean :is_lent, null:false, default:true

      t.timestamps
    end
  end
end
