require 'i18n/backend/active_record'
LANGUAGES = [['English', 'en']]

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
    def get_current_locale_keys(hsh = nil,
                                parent = nil,
                                ary = [],
                                current_locale = I18n.locale.to_s)
      hsh = YAML.load_file("config/locales/#{current_locale}.yml") unless hsh
      hsh.keys.each do |key|
        hsh.fetch(key).is_a?(Hash) ?
            get_current_locale_keys(hsh.fetch(key), key, ary) :
            hsh.keys.each do |child|
              (parent == current_locale) ? ary << child : ary << "#{parent}.#{child}"
            end
      end
      ary.uniq
    end
  end
end