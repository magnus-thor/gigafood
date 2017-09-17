class Translation < ApplicationRecord
  validates_presence_of :value, :locale, :key

  after_touch :reload_i18n_backend

  private
  def reload_i18n_backend
    I18n.backend.reload!
  end
end
