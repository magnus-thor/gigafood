class ShoppingCart < ApplicationRecord
  acts_as_shopping_cart

  def tax_pct
    12
  end
end
