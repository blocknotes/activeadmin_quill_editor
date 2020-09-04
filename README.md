# ActiveAdmin Quill Editor [![Gem Version](https://badge.fury.io/rb/activeadmin_quill_editor.svg)](https://badge.fury.io/rb/activeadmin_quill_editor) [![CircleCI](https://circleci.com/gh/blocknotes/activeadmin_quill_editor.svg?style=svg)](https://circleci.com/gh/blocknotes/activeadmin_quill_editor)

An Active Admin plugin to use [Quill Rich Text Editor](https://github.com/quilljs/quill) in form fields.

![screenshot](screenshot.png)

## Install
- After installing Active Admin, add to your Gemfile: `gem 'activeadmin_quill_editor'` (and execute *bundle*)
- Add at the end of your Active Admin styles (_app/assets/stylesheets/active_admin.scss_):
```scss
@import 'activeadmin/quill_editor/quill.snow';
@import 'activeadmin/quill_editor_input';
```
- Add at the end of your Active Admin javascripts (_app/assets/javascripts/active_admin.js_):
```js
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input
```
- Use the input with `as: :quill_editor` in Active Admin model conf

Why 2 separated scripts/styles? In this way you can include a different version of *quill editor* if you like.

> **UPDATE FROM VERSION <= 2.0**: please add to your _app/assets/stylesheets/active_admin.scss_ the line `@import 'activeadmin/quill_editor/quill.snow';`

## Options
**data-options**: permits to set *quill editor* options directly - see [options list](https://quilljs.com/docs/configuration/)

## Examples

### Basic usage

```ruby
# Active Admin article form conf:
  form do |f|
    f.inputs 'Article' do
      f.input :title
      f.input :description, as: :quill_editor
      f.input :published
    end
    f.actions
  end
```

### Toolbar buttons configuration

```ruby
f.input :description, as: :quill_editor, input_html: { data: { options: { modules: { toolbar: [['bold', 'italic', 'underline'], ['link']] }, placeholder: 'Type something...', theme: 'snow' } } }
```

## Notes
- Upload features (images/documents/files): not tested yet.

## Do you like it? Star it!
If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Take a look at [other Active Admin components](https://github.com/blocknotes?utf8=✓&tab=repositories&q=activeadmin&type=source) that I made if you are curious.

## Contributors
- [Mattia Roccoberton](http://blocknot.es): author
- The good guys that opened issues and pull requests from time to time

## License
The gem is available as open-source under the terms of the [MIT](LICENSE.txt).
