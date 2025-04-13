# frozen_string_literal: true

module Shared
  class HtmlEditor < BaseObject
    def content_element
      raise NotImplementedError
    end

    def clear
      select_all
      content_element.send_keys(:delete)
      self
    end

    # @return [self]
    def open_dropdown
      raise NotImplementedError
    end

    def select_all
      content_element.send_keys([:control, "a"])
      self
    end

    def toolbar_control(control, ...)
      send(:"toggle_#{control}", ...)
      self
    end

    def <<(content)
      content_element.send_keys(content)
      self
    end
  end
end
