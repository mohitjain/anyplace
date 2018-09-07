class RenameColumnInAvailabilities < ActiveRecord::Migration[5.2]
  def change
    rename_column :availabilities, :hotel_room_id, :room_type_id
  end
end
