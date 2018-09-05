class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :auth_token, null: false, unique: true
      t.uuid :user_id, null: false
      t.timestamps
    end
  end
end
