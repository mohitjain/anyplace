class AddActiveToRoomTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :room_types, :active, :boolean, default: true, null: false
  end
end
