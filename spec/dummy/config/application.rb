require_relative 'boot'

require 'rails/all'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0 if Rails::VERSION::MAJOR == 6

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    ###

    config.active_record.legacy_connection_handling = false if Gem::Version.new(Rails.version) < Gem::Version.new('7.1')

    config.before_configuration do
      ActiveSupport::Cache.format_version = 7.0 if Gem::Version.new(Rails.version) > Gem::Version.new('7.0')
    end
  end
end
