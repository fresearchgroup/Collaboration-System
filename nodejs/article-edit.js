var Quill = require('quill');
var Delta = require('quill-delta');
var sharedb = require('sharedb/lib/client');
var richText = require('rich-text');
sharedb.types.register(richText.type);


// TODO: Use env variables to get these values
// var SHAREDB_SERVER_IP = '10.16.23.129';
var SHAREDB_SERVER_PORT = '8080';

var socket = new WebSocket(`ws://${window.location.hostname}:${SHAREDB_SERVER_PORT}`);

var connection = new sharedb.Connection(socket);

var toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  ['blockquote', 'code-bloprocess.env.SHAREDB_SERVER_IPck'],

  [{
    'header': 1
  }, {
    'header': 2
  }], // custom button values
  [{
    'list': 'ordered'
  }, {
    'list': 'bullet'
  }],
  [{
    'script': 'sub'
  }, {
    'script': 'super'
  }], // superscript/subscript
  [{
    'indent': '-1'
  }, {
    'indent': '+1'
  }], // outdent/indent
  [{
    'direction': 'rtl'
  }], // text direction

  [{
    'size': ['small', false, 'large', 'huge']
  }], // custom dropdown
  [{
    'header': [1, 2, 3, 4, 5, 6, false]
  }],

  [{
    'color': []
  }, {
    'background': []
  }], // dropdown with defaults from theme
  [{
    'font': []
  }],
  [{
    'align': []
  }],

  ['clean'],
  ['link', 'image', 'video'] // remove formatting button
];

var quill = new Quill('#editor', {
  modules: {
    toolbar: {
      container: toolbarOptions,
      handlers: {
        image: selectLocalImage
      }
    }
  },
  theme: 'snow'
});

var doc = connection.get('collaborative_community', `${id}`);
doc.subscribe(function (err) {
  if (err) throw err;

  quill.setContents(doc.data);
  quill.on('text-change', function (delta, oldDelta, source) {
    if (source !== 'user') return;
    doc.submitOp(delta, {
      source: quill
    });
  });

  doc.on('op', function (op, source) {
    if (source === quill) return;
    quill.updateContents(op);
  });
});


$('#savechanges').click(function (e) {
  var content = document.querySelector('input[name=body]');
  content.value = JSON.stringify(quill.getContents());
});

$('.state-change-btn').click(function (e) {
  var content = document.querySelector('input[name=body]');
  content.value = JSON.stringify(quill.getContents());
});

/**
 * Step1. select local image
 *
 */
function selectLocalImage() {
  const input = document.createElement('input');
  input.setAttribute('type', 'file');
  input.click();

  // Listen upload local image and save to server
  input.onchange = () => {
    const file = input.files[0];

    // file type is only image.
    if (/^image\//.test(file.type)) {
      saveToServer(file);
    } else {
      console.warn('You could only upload images.');
    }
  };
}

/**
 * Step2. save to server
 *
 * @param {File} file
 */
function saveToServer(file) {
  const fd = new FormData();
  fd.append('image', file);
  filename = file.name;
  var reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = function() {
    $.ajax({
      url: '/articles/save-image/',
      type: 'post',
      data: {
        filename: filename,
        image_base64: reader.result
      },
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRFToken', Cookies.get('csrftoken'))
      },
      success: function(data) {
        insertToEditor(data.url);
      }

    })
  }
}

function insertToEditor(url) {
  // push image url to rich editor.
  const range = quill.getSelection();
  quill.insertEmbed(range.index, 'image', url, 'user');
}