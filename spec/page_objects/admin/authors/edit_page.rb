# frozen_string_literal: true

require_relative '../../base_page'

module Admin
  module Authors
    class EditPage < BasePage
      include Capybara::DSL
    end
  end
end
