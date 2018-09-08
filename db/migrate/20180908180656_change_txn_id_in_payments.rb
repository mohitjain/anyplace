class ChangeTxnIdInPayments < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :txnid, :string, null: false, unique: true, index: true
  end
end
