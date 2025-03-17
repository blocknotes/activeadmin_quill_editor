# frozen_string_literal: true

RSpec.describe 'Quill JS' do
  it 'has a Javascript function defined and returns the version', :aggregate_failures do
    visit '/admin/posts'

    expect(page.evaluate_script('typeof Quill')).to eq 'function'
    expect(page.evaluate_script('Quill.version')).to eq(ActiveAdmin::QuillEditor::QUILL_VERSION)
  end

  describe '.getQuillEditors' do
    let(:author) { Author.create!(email: 'some_email@example.com', name: 'John Doe', age: 30) }
    let!(:post) { Post.create!(title: 'Test', author: author, description: '') }

    before do
      path = edit_admin_post_path(post)
      Admin::Posts::EditPage.new(path: path).load
    end

    it "returns the available editors", :aggregate_failures do
      editors_count = page.evaluate_script('window.getQuillEditors().length')
      expect(editors_count).to eq 2

      expected_element = find('#post_summary > .ql-container')
      first_editor = page.evaluate_script('window.getQuillEditors()[0].container')
      expect(first_editor).to eq expected_element

      expected_element = find('#post_description > .ql-container')
      first_editor = page.evaluate_script('window.getQuillEditors()[1].container')
      expect(first_editor).to eq expected_element
    end
  end

  describe '.getQuillEditorByIndex' do
    let(:author) { Author.create!(email: 'some_email@example.com', name: 'John Doe', age: 30) }
    let!(:post) { Post.create!(title: 'Test', author: author, description: '') }

    before do
      path = edit_admin_post_path(post)
      Admin::Posts::EditPage.new(path: path).load
    end

    it "returns the expected editor instance" do
      expected_element = find('#post_description > .ql-container')
      editor = page.evaluate_script('window.getQuillEditorByIndex(1).container')
      expect(editor).to eq expected_element
    end
  end

  describe '.getQuillEditorByElementId' do
    let(:author) { Author.create!(email: 'some_email@example.com', name: 'John Doe', age: 30) }
    let!(:post) { Post.create!(title: 'Test', author: author, description: '') }

    before do
      path = edit_admin_post_path(post)
      Admin::Posts::EditPage.new(path: path).load
    end

    it "returns the expected editor instance" do
      expected_element = find('#post_description > .ql-container')
      editor = page.evaluate_script('window.getQuillEditorByElementId("post_description").container')
      expect(editor).to eq expected_element
    end
  end
end
