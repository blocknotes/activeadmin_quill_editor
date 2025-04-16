/* globals $ Quill ImageUploader */
(function () {
  'use strict';

  // --- functions ---------------------------------------------------------------
  const initQuillEditors = () => {
    const defaultTheme = 'snow';
    const defaultToolbar = [
      ['bold', 'italic', 'underline'],
      ['link', 'blockquote', 'code-block'],
      [{ 'script': 'sub' }, { 'script': 'super' }],
      [{ 'align': [] }, { list: 'ordered' }, { list: 'bullet' }],
      [{ 'color': [] }, { 'background': [] }],
      ['image'],
      ['clean'],
    ];
    const editors = document.querySelectorAll('[data-aa-quill-editor]');
    const registeredPlugins = {};

    for (let i = 0; i < editors.length; i++) {
      const content = editors[i].querySelector('[data-aa-quill-content]');
      const isActive = editors[i].classList.contains('quill-editor--active');

      if (content && !isActive) {
        // Setup editor options
        const options = editors[i].getAttribute('data-options') ? JSON.parse(editors[i].getAttribute('data-options')) : {};

        if (!options.theme) options.theme = defaultTheme;
        if (!options.modules) options.modules = {};
        if (!options.modules.toolbar) options.modules.toolbar = defaultToolbar;

        // Setup plugin options
        const pluginOptions = editors[i].getAttribute('data-plugins') ? JSON.parse(editors[i].getAttribute('data-plugins')) : {};

        if (pluginOptions.image_uploader && pluginOptions.image_uploader.server_url) {
          if (!registeredPlugins.image_uploader) {
            Quill.register('modules/imageUploader', ImageUploader);
            registeredPlugins.image_uploader = true;
          }
          const opts = pluginOptions.image_uploader;

          options.modules.imageUploader = setupImageUploader(opts.server_url, opts.field_name);
        }

        // Init editor
        editors[i]['_quill-editor'] = new Quill(content, options);
        editors[i].classList += ' quill-editor--active';
      }
    }

    const formtastic = document.querySelector('form.formtastic');

    if (formtastic) {
      formtastic.onsubmit = () => {
        for (let i = 0; i < editors.length; i++) {
          const input = editors[i].querySelector('input[type="hidden"]');

          if (editors[i]['_quill-editor'].editor.isBlank()) {
            input.value = '';
          } else {
            input.value = editors[i]['_quill-editor'].root.innerHTML;
          }
        }
      };
    }
  };

  const setupImageUploader = (server_url, field_name) => {
    return {
      upload: (file) => {
        return new Promise((resolve, reject) => {
          const formData = new FormData();

          formData.append(field_name || 'file_upload', file);
          fetch(server_url, {
            body: formData,
            headers: {
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            },
            method: 'POST'
          }).then(response => response.json())
            .then(result => {
              if (!result.url) {
                reject('Upload failed');
              }
              resolve(result.url);
            })
            .catch(error => {
              reject('Upload failed');
              console.error('Error: ', error);
            })
        })
      }
    }
  }

  // --- public functions --------------------------------------------------------
  window.getQuillEditors = function() {
    const editors = document.querySelectorAll('[data-aa-quill-editor]');
    const list = [];

    editors.forEach(function(editor) { list.push(editor['_quill-editor']) });

    return list;
  }

  window.getQuillEditorByIndex = function(index) {
    const editors = document.querySelectorAll('[data-aa-quill-editor]');

    return (index >= 0 && index < editors.length) ? editors[index]['_quill-editor'] : null;
  }

  window.getQuillEditorByElementId = function(id) {
    const editor = document.querySelector(`[data-aa-quill-editor]#${id}`);

    return editor ? editor['_quill-editor'] : null;
  }

  // --- events ------------------------------------------------------------------
  $(document).ready(initQuillEditors);
  $(document).on('has_many_add:after', '.has_many_container', initQuillEditors);
  $(document).on('turbolinks:load', initQuillEditors);
})();
