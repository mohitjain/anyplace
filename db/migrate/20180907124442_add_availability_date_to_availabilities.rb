class AddAvailabilityDateToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :availability_date, :date, null: false
    add_index :availabilities, [:hotel_id, :availability_date]
    add_index :availabilities, [:room_type_id, :availability_date]
    add_index :pricings, [:hotel_id, :price_date]
    add_index :pricings, [:room_type_id, :price_date]
  end
end
