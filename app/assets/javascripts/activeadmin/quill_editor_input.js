// --- functions ---------------------------------------------------------------
function initQuillEditors() {
  var default_theme = 'snow';
  var default_toolbar = [
    ['bold', 'italic', 'underline'],
    ['link', 'blockquote', 'code-block'],
    [{ 'script': 'sub'}, { 'script': 'super' }],
    [{ 'align': [] }, { list: 'ordered' }, { list: 'bullet' }],
    [{ 'color': [] }, { 'background': [] }],
    ['image'],
    ['clean'],
  ];
  var editors = document.querySelectorAll('.quill-editor');
  var registered_plugins = {};

  for(var i = 0; i < editors.length; i++) {
    var content = editors[i].querySelector('.quill-editor-content');
    var isActive = editors[i].classList.contains('quill-editor--active');
    if(content && !isActive) {
      // Setup editor options
      var options = editors[i].getAttribute('data-options') ? JSON.parse(editors[i].getAttribute('data-options')) : {};
      if(!options.theme) options.theme = default_theme;
      if(!options.modules) options.modules = {};
      if(!options.modules.toolbar) options.modules.toolbar = default_toolbar;

      // Setup plugin options
      var plugin_options = editors[i].getAttribute('data-plugins') ? JSON.parse(editors[i].getAttribute('data-plugins')) : {};
      if(plugin_options.image_uploader && plugin_options.image_uploader.server_url) {
        if(!registered_plugins.image_uploader) {
          Quill.register('modules/imageUploader', ImageUploader);
          registered_plugins.image_uploader = true;
        }
        var opts = plugin_options.image_uploader;
        options.modules.imageUploader = setupImageUploader(opts.server_url, opts.field_name);
      }

      // Init editor
      editors[i]['_quill-editor'] = new Quill(content, options);
      editors[i].classList += ' quill-editor--active';
    }
  }

  var formtastic = document.querySelector('form.formtastic');
  if(formtastic) {
    formtastic.onsubmit = function() {
      for(var i = 0; i < editors.length; i++) {
        var input = editors[i].querySelector('input[type="hidden"]');
        if (editors[i]['_quill-editor'].editor.isBlank()) {
          input.value = '';
        } else {
          input.value = editors[i]['_quill-editor'].root.innerHTML;
        }
      }
    };
  }
}

function setupImageUploader(server_url, field_name) {
  return {
    upload: file => {
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
          resolve(result.url);
        })
        .catch(error => {
          reject('Upload failed');
          console.error('Error: ', error);
        });
      });
    }
  }
}

// --- events ------------------------------------------------------------------
$(document).ready( function() {
  initQuillEditors();
});

$(document).on('has_many_add:after', function() {
  initQuillEditors();
});
