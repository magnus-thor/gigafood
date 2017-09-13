class DropShoppingCartTables < ActiveRecord::Migration[5.1]
  def up
    drop_table :shopping_cart_items
    drop_table :shopping_carts
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end