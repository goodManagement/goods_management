class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, null:false
      t.integer :serial_number, null:false, unique:true
      t.integer :kind, null:false

      t.timestamps
    end
  end
end
