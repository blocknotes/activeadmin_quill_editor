# frozen_string_literal: true

using StringCleanMultiline

RSpec.describe 'Quill editor' do
  let(:author) { Author.create!(email: 'some_email@example.com', name: 'John Doe', age: 30) }
  let(:post) do
    Post.create!(title: 'Test', author: author, description: '<p>Some content</p>', summary: '<p>Post summary</p>')
  end

  let(:submit_button) { find('#post_submit_action [type="submit"]') }

  context 'with a Quill editor' do
    let(:edit_page) do
      path = edit_admin_post_path(post)
      Admin::Posts::EditPage.new(path: path)
    end
    let(:editor) { edit_page.lookup_editor(editor_container: '#post_description_input') }
    let(:input_field) { find('#post_description[data-aa-quill-editor]') }

    before do
      edit_page.load
    end

    it 'initializes the editor', :aggregate_failures do
      expect(editor.content_element).to be_present
      expect(editor.content).to eq('<p>Some content</p>')
      expect(input_field).to be_present
    end

    it 'edits some content using the editor' do
      editor.select_all
      editor.toggle_link
      editor.tooltip_editing.send_keys(["https://blocknot.es", :return])

      editor << :right << :return << 'More content'
      editor.toggle_bold
      editor << 'Some bold'
      editor.toggle_italic
      editor << 'Some italic'
      editor.toggle_underline
      editor << 'Some underline' << :return

      editor.toggle_blockquote
      editor << 'blockquote enabled' << :return
      editor.toggle_blockquote

      editor.toggle_code_block
      editor << 'code block enabled' << :return
      editor.toggle_code_block

      editor << "Some text"
      editor.toggle_sub
      editor << "sub text"
      editor.toggle_sub
      editor << " More text"
      editor.toggle_super
      editor << "sup text"
      editor.toggle_super
      editor << :return

      editor.open_dropdown(:align).toggle_align_right
      editor << "Text aligned on the right"

      expect(editor.content).to eq <<~HTML.clean_multiline
        <p><a href="https://blocknot.es" rel="noopener noreferrer" target="_blank">Some content</a></p>
        <p>More content<strong>Some bold<em>Some italic<u>Some underline</u></em></strong></p>
        <blockquote>blockquote enabled</blockquote>
        <div class="ql-code-block-container" spellcheck="false">
          <div class="ql-code-block">code block enabled</div>
        </div>
        <p>Some text<sub>sub text</sub> More text<sup>sup text</sup></p>
        <p class="ql-align-right">Text aligned on the right</p>
      HTML
    end

    it 'updates the field when submitting', :aggregate_failures do
      editor.toggle_bold
      editor << 'More content'

      before = '<p>Some content</p>'
      after = '<p><strong>More content</strong>Some content</p>'
      expect { submit_button.click }.to change { post.reload.description }.from(before).to(after)

      expect(page).to have_content('was successfully updated')
    end
  end

  context 'with 2 Quill editors' do
    let(:edit_page) do
      path = edit_admin_post_path(post)
      Admin::Posts::EditPage.new(path: path)
    end
    let(:first_editor) { edit_page.lookup_editor(editor_container: '#post_description_input') }
    let(:second_editor) { edit_page.lookup_editor(editor_container: '#post_summary_input') }

    before do
      edit_page.load
    end

    it 'updates some HTML content for 2 fields', :aggregate_failures do
      # Check the initial states
      expect(first_editor.content).to eq('<p>Some content</p>')
      expect(second_editor.content).to eq('<p>Post summary</p>')

      # Add some content to both the editors
      first_editor.toggle_bold
      first_editor << 'Some bold'

      second_editor.toggle_italic
      second_editor << 'Some italic'

      # Check that both the fields change
      before = '<p>Some content</p>'
      after = '<p><strong>Some bold</strong>Some content</p>'
      expect { submit_button.click }.to change { post.reload.description }.from(before).to(after)

      expect(post.summary).to eq '<p><em>Some italic</em>Post summary</p>'
    end
  end

  context 'with a Quill editor in a nested resource' do
    let(:edit_page) do
      path = edit_admin_author_path(author)
      Admin::Authors::EditPage.new(path: path)
    end
    let(:submit_button) { find('#author_submit_action [type="submit"]') }

    before do
      post
      edit_page.load
    end

    it 'updates some HTML content of a new nested resource', :aggregate_failures do
      click_on 'Add New Post'

      first_editor = edit_page.lookup_editor(editor_container: '#author_posts_attributes_0_description_input')
      expect(first_editor.content).to eq('<p>Some content</p>')

      fill_in('author[posts_attributes][1][title]', with: 'Some title')
      second_editor = edit_page.lookup_editor(editor_container: '#author_posts_attributes_1_description_input')
      second_editor.toggle_underline
      second_editor << 'Some underline'

      expect { submit_button.click }.to change(Post, :count).by(1)
      expect(Post.last.description).to eq '<p><u>Some underline</u></p>'
    end
  end
end
