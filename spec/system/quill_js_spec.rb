# frozen_string_literal: true

RSpec.describe 'Quill JS' do
  it 'has a Javascript function defined and returns the version', :aggregate_failures do
    visit '/admin/posts'

    expect(page.evaluate_script('typeof Quill')).to eq 'function'
    expect(page.evaluate_script('Quill.version')).to eq(ActiveAdmin::QuillEditor::QUILL_VERSION)
  end
end
