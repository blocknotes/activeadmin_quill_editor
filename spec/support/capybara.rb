# frozen_string_literal: true

require 'capybara/cuprite'

Capybara.register_driver(:capybara_cuprite) do |app|
  browser_options = {}.tap do |opts|
    opts['no-sandbox'] = nil if ENV['DEVEL']
  end

  Capybara::Cuprite::Driver.new(
    app,
    window_size: [1600, 1024],
    browser_options: browser_options,
    process_timeout: 30,
    timeout: 30,
    inspector: true,
    headless: !ENV['CUPRITE_HEADLESS'].in?(%w[n 0 no false])
  )
end

# Capybara.server = :puma
Capybara.default_driver = Capybara.javascript_driver = :capybara_cuprite

RSpec.configure do |config|
  config.prepend_before(:each, type: :system) do
    driven_by Capybara.javascript_driver
  end
end
