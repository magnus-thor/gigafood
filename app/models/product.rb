class Product < ApplicationRecord
  belongs_to :category, optional: true
  validates :category, presence: true, unless: :is_cutlery?
  validates_inclusion_of :of_type, in: ['dish', 'cutlery']

  scope :dishes, -> {where(of_type: 'dish')}
  scope :cutlery, -> {where(of_type: 'cutlery')}

  def is_cutlery?
    self.of_type == 'cutlery'
  end
end
