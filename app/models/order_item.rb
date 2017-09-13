class OrderItem < ApplicationRecord
  acts_as_shopping_cart_item_for :order
end
