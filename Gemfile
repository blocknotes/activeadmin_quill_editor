# frozen_string_literal: true

source 'https://rubygems.org'

if ENV["DEVEL"] == "1"
  gem 'rails', '~> 7.1.0'

  gem 'activeadmin', '~> 3.3'
  gem 'activeadmin_quill_editor', path: './'
else
  gemspec
end

gem 'puma'
gem 'sassc'
gem 'sprockets-rails'
gem 'sqlite3'

# Testing
gem 'capybara'
gem 'cuprite'
gem 'rspec_junit_formatter'
gem 'rspec-rails'
gem 'rspec-retry'

# Linters
gem 'fasterer'
gem 'rubocop'
gem 'rubocop-packaging'
gem 'rubocop-performance'
gem 'rubocop-rails'
gem 'rubocop-rspec'

# Tools
gem 'pry-rails'
