class Order < ApplicationRecord
  acts_as_shopping_cart_using :order_item
  SWEDISH_VAT = 12
  STANDARD_PAYMENT_TIME_IN_DAYS = 30

  has_many :attachments, dependent: :destroy

  scope :with_pending_posts, -> { joins(:attachments).where('attachments.file_type = "invoice"') }

  def tax_pct
    Order::SWEDISH_VAT
  end

  def set_payment_due_date
    self.update_attribute(:due_date, Date.today + Order::STANDARD_PAYMENT_TIME_IN_DAYS)
  end

  def has_invoice?
    Order.find(self.id).attachments.exists?(file_type: 'invoice')
  end
end
