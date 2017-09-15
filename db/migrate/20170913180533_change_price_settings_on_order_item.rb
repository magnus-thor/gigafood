class ChangePriceSettingsOnOrderItem < ActiveRecord::Migration[5.1]
  def change
    remove_column :order_items, :price_currency, :string
    remove_column :order_items, :price_cents, :integer
    add_monetize :order_items, :price
  end
end
