class AddGatewayIdToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :gateway_id, :string
  end
end
