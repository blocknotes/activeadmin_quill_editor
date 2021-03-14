# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activeadmin/quill_editor/version'

Gem::Specification.new do |spec|
  spec.name          = 'activeadmin_quill_editor'
  spec.version       = ActiveAdmin::QuillEditor::VERSION
  spec.summary       = 'Quill Editor for ActiveAdmin'
  spec.description   = 'An Active Admin plugin to use Quill Rich Text Editor'
  spec.license       = 'MIT'
  spec.authors       = ['Mattia Roccoberton']
  spec.email         = 'mat@blocknot.es'
  spec.homepage      = 'https://github.com/blocknotes/activeadmin_quill_editor'

  spec.files         = Dir['{app,lib}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeadmin', '~> 2.0'

  spec.add_development_dependency 'activestorage', '~> 6.0'
  spec.add_development_dependency 'capybara', '~> 3.33'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'puma', '~> 4.3'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4'
  spec.add_development_dependency 'rspec-rails', '~> 4.0'
  spec.add_development_dependency 'rubocop', '~> 0.90'
  spec.add_development_dependency 'sassc', '~> 2.4'
  spec.add_development_dependency 'selenium-webdriver', '~> 3.142'
  spec.add_development_dependency 'sprockets-rails', '~> 3.2'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
end
