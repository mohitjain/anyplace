class AddNumberOfRoomsToRoomTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :room_types, :number_of_rooms, :integer, default: 0, null: false
  end
end
