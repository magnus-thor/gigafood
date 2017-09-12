class AddBoxesToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :boxes, :integer
  end
end
