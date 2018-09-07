class AddIndexUniqueForPricingAndAvailability < ActiveRecord::Migration[5.2]
  def change
    remove_index :availabilities, name: :index_availabilities_on_room_type_id_and_availability_date
    add_index :availabilities, [:room_type_id, :availability_date], unique: true
    remove_index :pricings, name: :index_pricings_on_room_type_id_and_price_date
    add_index :pricings, [:room_type_id, :price_date], unique: true
  end
end
