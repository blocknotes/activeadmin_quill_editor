# frozen_string_literal: true

class BasePage
  include Capybara::DSL

  attr_reader :path

  def initialize(path:)
    @path = path
  end

  def load
    visit(path)
  end
end
