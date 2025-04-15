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

    def open_dropdown(dropdown)
      find("#{toolbar_selector} .ql-#{dropdown} .ql-picker-label").click
      self
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

    def toggle_blockquote
      find("#{toolbar_selector} button.ql-blockquote").click
    end

    def toggle_code_block
      find("#{toolbar_selector} button.ql-code-block").click
    end

    def toggle_sub
      find("#{toolbar_selector} button.ql-script[value='sub']").click
    end

    def toggle_super
      find("#{toolbar_selector} button.ql-script[value='super']").click
    end

    def toggle_align_right
      find("#{toolbar_selector} .ql-picker-item[data-value='right']").click
    end

    def tooltip_editing
      find("#{editor_selector} .ql-tooltip.ql-editing")
    end
  end
end
