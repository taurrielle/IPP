class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :service
      t.integer :room
      t.string :order
      t.string :status, default: "PENDING"

      t.timestamps
    end
  end
end
