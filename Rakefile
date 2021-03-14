# frozen_string_literal: true

require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    # t.ruby_opts = %w[-w]
    t.rspec_opts = ['--color', '--format documentation']
  end

  task default: :spec
rescue LoadError
  puts '! LoadError: no RSpec available'
end
