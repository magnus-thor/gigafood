require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Gigafood
  class Application < Rails::Application
    config.load_defaults 5.1
    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.view_specs false
      generate.helper_specs false
      generate.routing_specs false
      generate.controller_specs false
    end

    config.i18n.available_locales = [:en, :sw]
    config.i18n.default_locale = :en

    config.generators.system_tests = nil

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  end
end
