# frozen_string_literal: true

module StringCleanMultiline
  refine String do
    def clean_multiline
      # Get rid of newlines and indentation spaces
      strip.gsub(/\s*\n\s*/, "")
    end
  end
end
