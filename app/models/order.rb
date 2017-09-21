class Order < ApplicationRecord
  acts_as_shopping_cart_using :order_item
  SWEDISH_VAT = 12
  STANDARD_PAYMENT_TIME_IN_DAYS = 10

  has_many :attachments, dependent: :destroy

  def tax_pct
    Order::SWEDISH_VAT
  end

  def set_payment_due_date
    self.update_attribute(:due_date, Date.today + Order::STANDARD_PAYMENT_TIME_IN_DAYS)
  end

  def has_invoice?
    Order.find(self.id).attachments.exists?(file_type: 'invoice')
  end

  def has_menu?
    Order.find(self.id).attachments.exists?(file_type: 'menu')
  end
end
