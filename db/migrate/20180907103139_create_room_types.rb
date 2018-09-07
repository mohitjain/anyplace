class CreateRoomTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :room_types, id: :uuid do |t|
      t.integer :category, null: false, default: 0
      t.uuid :hotel_id, null: false, index: true
      t.timestamps
    end
  end
end
