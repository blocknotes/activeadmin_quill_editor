# frozen_string_literal: true

class QuillEditor < HtmlEditor
  SELECTOR = '.ql-container'
  TOOLBAR_SELECTOR = '.ql-toolbar'

  attr_reader :toolbar, :toolbar_selector

  def initialize(selector: SELECTOR, toolbar_selector: TOOLBAR_SELECTOR)
    super(selector: selector)
    @toolbar = find(toolbar_selector)
    @toolbar_selector = toolbar_selector
  end

  def content_element
    @content_element ||= find("#{selector} .ql-editor")
  end

  def control_selector(control)
    case control&.to_sym
    when :bold then "#{toolbar_selector} button.ql-bold"
    when :italic then "#{toolbar_selector} button.ql-italic"
    when :underline then "#{toolbar_selector} button.ql-underline"
    when :link then "#{toolbar_selector} button.ql-link"
    else raise "Invalid control #{control}"
    end
  end

  def toggle_bold
    find(control_selector(:bold)).click
  end

  def toggle_italic
    find(control_selector(:italic)).click
  end

  def toggle_underline
    find(control_selector(:underline)).click
  end

  def toggle_link
    find(control_selector(:link)).click
  end
end
