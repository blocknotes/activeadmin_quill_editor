# frozen_string_literal: true

Capybara.server = :puma
Capybara.default_driver = Capybara.javascript_driver = :cuprite

RSpec.configure do |config|
  # Make sure this hook runs before others
  config.prepend_before(:each, type: :system) do
    # Use JS driver always
    driven_by Capybara.javascript_driver
  end
end
