# frozen_string_literal: true

module Shared
  class QuillEditor < HtmlEditor
    attr_reader :editor_selector, :toolbar_selector

    def initialize(container)
      @editor_selector = "#{container} .ql-container"
      @toolbar_selector = "#{container} .ql-toolbar"
      super(selector: editor_selector)
    end

    def content = content_element['innerHTML']

    def content_element
      @content_element ||= find("#{selector} .ql-editor")
    end

    def toggle_bold
      find("#{toolbar_selector} button.ql-bold").click
    end

    def toggle_italic
      find("#{toolbar_selector} button.ql-italic").click
    end

    def toggle_underline
      find("#{toolbar_selector} button.ql-underline").click
    end

    def toggle_link
      find("#{toolbar_selector} button.ql-link").click
    end
  end
end
