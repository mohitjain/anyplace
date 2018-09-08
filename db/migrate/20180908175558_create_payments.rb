class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments, id: :uuid do |t|
      t.uuid :booking_id, null: false, index: true
      t.integer :gateway, null: false, default: 0
      t.string :txnid, index: true, null: false
      t.float :amount, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
