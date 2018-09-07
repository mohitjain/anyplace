class RenameTableAvailaility < ActiveRecord::Migration[5.2]
  def change
    rename_table :availabilties, :availabilities
  end
end
