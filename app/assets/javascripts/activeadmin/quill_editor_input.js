window.onload = function() {
  initQuillEditors();
}

$(document).on('has_many_add:after', function() {
  initQuillEditors();
});

var initQuillEditors = function() {
  var editors = document.querySelectorAll('.quill-editor');
  var default_options = {
    modules: {
      toolbar: [
        ['bold', 'italic', 'underline'],
        ['link', 'blockquote', 'code-block'],
        [{ 'script': 'sub'}, { 'script': 'super' }],
        [{ 'align': [] }, { list: 'ordered' }, { list: 'bullet' }],
        [{ 'color': [] }, { 'background': [] }],
        ['clean'],
      ]
    },
    placeholder: '',
    theme: 'snow'
  };

  for(var i = 0; i < editors.length; i++) {
    var content = editors[i].querySelector('.quill-editor-content');
    var isActive = editors[i].classList.contains('quill-editor--active');
    if(content && !isActive) {
      var options = editors[i].getAttribute('data-options') ? JSON.parse(editors[i].getAttribute('data-options')) : default_options;
      editors[i]['_quill-editor'] = new Quill(content, options);
      editors[i].classList += ' quill-editor--active';
    }
  }

  var formtastic = document.querySelector('form.formtastic');
  if(formtastic) {
    formtastic.onsubmit = function() {
      for(var i = 0; i < editors.length; i++) {
        var input = editors[i].querySelector('input[type="hidden"]');
        input.value = editors[i]['_quill-editor'].root.innerHTML;
      }
    };
  }
};
