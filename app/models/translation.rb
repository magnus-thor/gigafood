class Translation < ApplicationRecord

  validates_presence_of :value
  validates_presence_of :locale
  validates_presence_of :key
end
