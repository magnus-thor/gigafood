class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.datetime :order_date
      t.datetime :delivery_date
      t.text :address
      t.string :phone
      t.text :allergies

      t.timestamps
    end
  end
end
