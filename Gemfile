# frozen_string_literal: true

source 'https://rubygems.org'

if ENV['DEVEL'] == '1'
  gem 'activeadmin_quill_editor', path: './'
else
  gemspec
end

ruby_ver = ENV.fetch('RUBY_VERSION', '')
rails_ver = ENV.fetch('RAILS_VERSION', '')
activeadmin_ver = ENV.fetch('ACTIVEADMIN_VERSION', '')

rails = rails_ver.empty? ? ['rails'] : ['rails', "~> #{rails_ver}"]
gem(*rails)

activeadmin = activeadmin_ver.empty? ? ['activeadmin'] : ['activeadmin', "~> #{activeadmin_ver}"]
gem(*activeadmin)

ruby32 = Gem::Version.new(ruby_ver) >= Gem::Version.new('3.2')
rails72 = Gem::Version.new(rails_ver) >= Gem::Version.new('7.2')
sqlite3 = ruby32 || rails72 ? ['sqlite3'] : ['sqlite3', '~> 1.4']
gem(*sqlite3)

# NOTE: to avoid error: uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger
gem 'concurrent-ruby', '1.3.4'

# Misc
gem 'bigdecimal'
gem 'csv'
gem 'mutex_m'
gem 'puma'
gem 'sassc'
gem 'sprockets-rails'

# Testing
gem 'capybara'
gem 'cuprite'
gem 'rspec_junit_formatter'
gem 'rspec-rails'
gem 'rspec-retry'
gem 'simplecov', require: false

# Linters
gem 'fasterer'
gem 'rubocop'
gem 'rubocop-capybara'
gem 'rubocop-packaging'
gem 'rubocop-performance'
gem 'rubocop-rails'
gem 'rubocop-rspec'
gem 'rubocop-rspec_rails'

# Tools
gem 'pry-rails'
