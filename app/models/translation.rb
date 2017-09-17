class Translation < ApplicationRecord
  validates_presence_of :value, :locale, :key
end
