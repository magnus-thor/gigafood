require 'i18n/backend/active_record'
LANGUAGES = [['English', 'en']]
Translation = I18n::Backend::ActiveRecord::Translation

if Translation.table_exists?
  I18n.backend = I18n::Backend::ActiveRecord.new

  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Flatten)
  I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
  I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

  I18n.backend = I18n::Backend::Chain.new(I18n.backend, I18n::Backend::Simple.new)
end

module I18n
  class << self
    def get_current_locale_keys(hsh = nil, parent = nil, ary = [])
      current_locale = I18n.locale.to_s
      hsh = YAML.load_file("config/locales/#{current_locale}.yml") unless hsh
      keys = hsh.keys
      keys.each do |key|
        if hsh.fetch(key).is_a?(Hash)
          get_current_locale_keys(hsh.fetch(key), "#{key}", ary)
        else
          keys.each do |another|
            if parent == current_locale
              ary << "#{another}"
            else
              ary << "#{parent}.#{another}"
            end

          end
        end
      end
      ary.uniq
    end
  end
end