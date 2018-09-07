class RemoveCategoryFromRoomTypes < ActiveRecord::Migration[5.2]
  def change
    remove_column :room_types, :category, :integer
  end
end
