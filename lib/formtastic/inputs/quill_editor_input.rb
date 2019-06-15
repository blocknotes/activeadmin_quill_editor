# frozen_string_literal: true

module Formtastic
  module Inputs
    class QuillEditorInput < Formtastic::Inputs::TextInput
      def to_html
        input_wrapping do
          label_html <<
            template.content_tag(:div, input_html_options.merge(class: 'quill-editor')) do
              builder.hidden_field(input_name) <<
                template.content_tag(:div, class: 'quill-editor-content') do
                  object.send(method).try :html_safe
                end
            end
        end
      end
    end
  end
end
