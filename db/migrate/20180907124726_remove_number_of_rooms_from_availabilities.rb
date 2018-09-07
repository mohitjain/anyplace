class RemoveNumberOfRoomsFromAvailabilities < ActiveRecord::Migration[5.2]
  def change
    remove_column :availabilities, :number_of_rooms, :integer
  end
end
