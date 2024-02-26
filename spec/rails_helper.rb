# frozen_string_literal: true

require 'spec_helper'

ENV['RAILS_ENV'] = 'test'

require File.expand_path('dummy/config/environment.rb', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
require 'rspec/retry'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |f| require f }

# Force deprecations to raise an exception.
# ActiveSupport::Deprecation.behavior = :raise

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures = false
  config.render_views = false

  config.default_retry_count = 2

  config.before(:suite) do
    intro = ('-' * 80)
    intro << "\n"
    intro << "- Ruby:        #{RUBY_VERSION}\n"
    intro << "- Rails:       #{Rails.version}\n"
    intro << "- ActiveAdmin: #{ActiveAdmin::VERSION}\n"
    intro << ('-' * 80)

    RSpec.configuration.reporter.message(intro)
  end
end
