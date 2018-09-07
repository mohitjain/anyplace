class AddNameToRoomTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :room_types, :name, :string, null: false
  end
end
