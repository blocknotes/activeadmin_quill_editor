# frozen_string_literal: true

class BaseObject
  include Capybara::DSL

  attr_reader :element, :selector

  def initialize(selector:)
    @selector = selector
    @element = find(selector)
  end
end
