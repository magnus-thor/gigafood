class Order < ApplicationRecord
  acts_as_shopping_cart_using :order_item

  SWEDISH_VAT = 12
  STANDARD_PAYMENT_TIME_IN_DAYS = 10
  DEFAULT_ATTRIBUTES = [:status, :delivery_date, :billing_company, :billing_org_nr,
                        :billing_address, :billing_postal_code, :billing_city, :billing_phone, :billing_email]
  DELIVERY_ATTRIBUTES = [:delivery_name, :delivery_name, :delivery_address, :delivery_postal_code, :delivery_city,
                         :delivery_contact_name, :delivery_contact_phone_number]

  validates_presence_of *DEFAULT_ATTRIBUTES, if: :submitted?
  validates_presence_of *DELIVERY_ATTRIBUTES, if: :delivery?

  scope :non_pending, -> { where.not(:status => 'pending') }
  scope :pending, -> { where(:status => 'pending') }

  has_many :attachments, dependent: :destroy

  def submitted?
    status == 'submitted'
  end

  def delivery?
    delivery_method == 'delivery'
  end

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
