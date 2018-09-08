class AddIndexToStatusInBookings < ActiveRecord::Migration[5.2]
  def change
    add_index :bookings, :status
  end
end
