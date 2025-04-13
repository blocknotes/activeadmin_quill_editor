# frozen_string_literal: true

require_relative 'spec_helper'

require 'zeitwerk'
loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/page_objects")
loader.setup

ENV['RAILS_ENV'] = 'test'

require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('dummy/config/environment.rb', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |f| require_relative f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  if Gem::Version.new(Rails.version) >= Gem::Version.new('7.1')
    config.fixture_paths = [Rails.root.join('spec/fixtures')]
  else
    config.fixture_path = Rails.root.join('spec/fixtures')
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures = false
  config.render_views = false

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
