class Order < ApplicationRecord
  acts_as_shopping_cart_using :order_item
  validates :delivery_date,       presence: true, :if => :submitted?
  validates :status,              presence: true, :if => :submitted?
  validates :delivery_method,     presence: true, :if => :submitted?
  validates :billing_company,     presence: true, :if => :submitted?
  validates :billing_org_nr,      presence: true, :if => :submitted?
  validates :billing_address,     presence: true, :if => :submitted?
  validates :billing_postal_code, presence: true, :if => :submitted?
  validates :billing_city,        presence: true, :if => :submitted?
  validates :billing_phone,       presence: true, :if => :submitted?
  validates :billing_email,       presence: true, :if => :submitted?

  SWEDISH_VAT = 12
  STANDARD_PAYMENT_TIME_IN_DAYS = 30

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

  def submitted?
    status == 'submitted'
  end
end
