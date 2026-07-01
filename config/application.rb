require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TimeTracker
  class Application < Rails::Application
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "Europe/Paris"

    config.i18n.available_locales = %i[en fr]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true

    config.exceptions_app = routes
  end
end
