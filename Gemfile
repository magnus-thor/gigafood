source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.3'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'activeadmin'
gem 'devise'
gem 'active_admin_flat_skin', github: 'ayann/active_admin_flat_skin'
gem 'rails-i18n', '~> 5.0.0'
gem 'acts_as_shopping_cart', github: 'dabit/acts_as_shopping_cart', branch: 'rails51'
gem 'responsive_active_admin'
gem 'active_admin_datetimepicker'

# Attachments
gem 'paperclip', '~> 5.0.0'
gem 'aws-sdk', '~> 2.10', '>= 2.10.27'
gem 'prawn-rails'

# Active Record Translations
gem 'i18n-active_record', require: 'i18n/active_record'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
  gem 'rspec-rails'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'cucumber-rails', require: false
  gem 'launchy'
  gem 'pry-byebug'
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'dotenv-rails'

end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'pdf-inspector', require: 'pdf/inspector'
end

group :development do

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
