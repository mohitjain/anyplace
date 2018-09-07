class AddOccupancyLimitToRoomTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :room_types, :occupancy_limit, :integer, null: false, default: 1
  end
end
