class AddActiveToHotel < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :active, :boolean, default: true, null: false
  end
end
