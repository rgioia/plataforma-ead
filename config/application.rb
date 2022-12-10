require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlataformaEad
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    I18n.load_path    += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.time_zone  = 'Brasilia'

    config.i18n.available_locales = %i[en pt-BR]
    config.i18n.default_locale = 'pt-BR'
  end
end
