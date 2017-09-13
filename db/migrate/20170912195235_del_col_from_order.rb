class DelColFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :name
    remove_column :orders, :description
    remove_column :orders, :price
    remove_column :orders, :order_date
    remove_column :orders, :address
    remove_column :orders, :phone
  end
end
