class Order < ApplicationRecord
  acts_as_shopping_cart_using :order_item
  SWEDISH_VAT = 12

  def tax_pct
    Order::SWEDISH_VAT
  end
end
