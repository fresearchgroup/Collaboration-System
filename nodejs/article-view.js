var Quill = require('quill');
var Delta = require('quill-delta');

var quill = new Quill('#editor', {
  readOnly: true,
  modules: {
    toolbar: '#toolbar'
  },
  theme: 'snow'
});

quill.setContents(new Delta(articleBody));

document.getElementById('toolbar').outerHTML = "";