class CreateAvailabilties < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilties, id: :uuid do |t|
      t.uuid :hotel_id, null: false
      t.uuid :hotel_room_id, null: false
      t.integer :number_of_rooms, null: false, default: 0
      t.integer :available_rooms, null: false, default: 0
      t.timestamps
    end

    add_index :availabilties, [:hotel_id, :hotel_room_id]
    add_index :availabilties, [:hotel_room_id, :hotel_id]
  end
end
