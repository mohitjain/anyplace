class CreatePricings < ActiveRecord::Migration[5.2]
  def change
    create_table :pricings, id: :uuid do |t|
      t.uuid :hotel_id, null: false
      t.uuid :room_type_id, null: false
      t.date :price_date, null: false
      t.float :price, null: false, default: 0
      t.timestamps
    end

    add_index :pricings, [:hotel_id, :room_type_id]
  end
end
