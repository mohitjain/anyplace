class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels, id: :uuid do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :description, null: false
      t.timestamps
    end

  end
end
