class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :hotel_id, null: false
      t.date :checkin, null: false
      t.date :checkout, null: false
      t.float :monthly_rent, null: false, default: 0
      t.float :rent, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.uuid :room_type_id, null: false
      t.integer :number_of_rooms, default: 1, null: false
      t.json :meta_data, null: false, default: {}

      t.timestamps
    end

    add_index :bookings, :user_id
    add_index :bookings, :hotel_id
    add_index :bookings, :checkout
    add_index :bookings, [:checkin, :checkout]
  end
end
