# frozen_string_literal: true

RSpec.describe 'Quill editor' do
  def lookup_editor(field:)
    selector = ["##{field}_input.quill_editor", QuillEditor::SELECTOR].join(' ')
    toolbar_selector = ["##{field}_input.quill_editor", QuillEditor::TOOLBAR_SELECTOR].join(' ')
    QuillEditor.new(selector: selector, toolbar_selector: toolbar_selector)
  end

  let(:author) { Author.create!(email: 'some_email@example.com', name: 'John Doe', age: 30) }
  let!(:post) { Post.create!(title: 'Test', author: author, description: '') }

  context 'with a Quill editor' do
    let(:editor) { lookup_editor(field: 'post_description') }

    before do
      path = edit_admin_post_path(post)
      Admin::Posts::EditPage.new(path: path).load
    end

    it 'adds some text to the description', :aggregate_failures do
      expect(page).to have_css('#post_description[data-aa-quill-editor]')
      editor << 'Some content...'
      %i[bold italic underline link].each do |control|
        expect(page).to have_css editor.control_selector(control)
      end
      expect(editor.content_element).to have_content('Some content...')
      expect { find('[type="submit"]').click }
        .to change { post.reload.description }.to '<p>Some content...</p>'
    end

    it 'adds some bold text to the description', :aggregate_failures do
      editor.toolbar_control(:bold)
      editor << 'Some bold text'

      expect(editor.content_element).to have_content('Some bold text')
      expect { find('[type="submit"]').click }
        .to change { post.reload.description }.to '<p><strong>Some bold text</strong></p>'
    end

    it 'adds some italic text to the description', :aggregate_failures do
      editor.toolbar_control(:italic)
      editor << 'Some italic text'

      expect(editor.content_element).to have_content('Some italic text')
      expect { find('[type="submit"]').click }
        .to change { post.reload.description }.to '<p><em>Some italic text</em></p>'
    end

    it 'adds some underline text to the description', :aggregate_failures do
      editor.toolbar_control(:underline)
      editor << 'Some underline text'

      expect(editor.content_element).to have_content('Some underline text')
      expect { find('[type="submit"]').click }
        .to change { post.reload.description }.to '<p><u>Some underline text</u></p>'
    end

    it 'adds a link to the description', :aggregate_failures do
      editor << "Just a link"
      editor.select_all
      editor.toolbar_control(:link)
      editor.element.find('[data-link]').send_keys("https://www.google.com", :return)

      expect(editor.content_element).to have_content('Just a link')
      html = '<p><a href="Just a linkhttps://www.google.com" rel="noopener noreferrer" target="_blank">Just a link</a></p>'
      expect { find('[type="submit"]').click }.to change { post.reload.description }.to html
    end
  end

  context 'with 2 Quill editors' do
    before do
      path = edit_admin_post_path(post)
      Admin::Posts::EditPage.new(path: path).load
    end

    it 'updates some HTML content for 2 fields', :aggregate_failures do
      editor1 = lookup_editor(field: 'post_description')
      editor1.clear.toolbar_control(:bold)
      editor1 << "Some description"

      editor2 = lookup_editor(field: 'post_summary')
      editor2.clear.toolbar_control(:italic)
      editor2 << "Some summary"

      find('[type="submit"]').click
      post.reload

      expect(post.description).to eq '<p><strong>Some description</strong></p>'
      expect(post.summary).to eq '<p><em>Some summary</em></p>'
    end
  end

  context 'with a Quill editor in a nested resource' do
    before do
      path = edit_admin_author_path(author)
      Admin::Authors::EditPage.new(path: path).load
    end

    it 'updates some HTML content of a new nested resource', :aggregate_failures do
      find('.posts.has_many_container .has_many_add').click
      expect(page).to have_css('.posts.has_many_container .ql-editor', count: 2)

      editor = lookup_editor(field: 'author_posts_attributes_1_description')
      editor << "Some post text"

      fill_in('author[posts_attributes][1][title]', with: 'A new post')
      find('[type="submit"]').click

      expect(page).to have_content('was successfully updated')
      expect(author.posts.last.description).to eq '<p>Some post text</p>'
    end
  end
end
