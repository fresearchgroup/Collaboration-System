var Quill = require('quill');
var Delta = require('quill-delta');
var sharedb = require('sharedb/lib/client');
var richText = require('rich-text');
sharedb.types.register(richText.type);


// TODO: Use env variables to get these values
var SHAREDB_SERVER_IP = '10.16.23.106';
var SHAREDB_SERVER_PORT = '8080';


var socket = new WebSocket(`ws://${SHAREDB_SERVER_IP}:${SHAREDB_SERVER_PORT}`);

var connection = new sharedb.Connection(socket);

var toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
  ['blockquote', 'code-bloprocess.env.SHAREDB_SERVER_IPck'],

  [{ 'header': 1 }, { 'header': 2 }],               // custom button values
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
  [{ 'direction': 'rtl' }],                         // text direction

  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
  [{ 'font': [] }],
  [{ 'align': [] }],

  ['clean'],
  ['link', 'image', 'video']                                        // remove formatting button
];

var quill = new Quill('#editor', {
  modules: {
    toolbar: toolbarOptions
  },
  theme: 'snow'
});

var doc = connection.get('collaborative_community', `${id}`);
doc.subscribe(function(err) {
  if (err) throw err;

  quill.setContents(doc.data);
  quill.on('text-change', function(delta, oldDelta, source) {
    if (source !== 'user') return;
    doc.submitOp(delta, {source: quill});
  });
  doc.on('op', function(op, source) {
    if (source === quill) return;
    quill.updateContents(op);
  });
});


$('#savechanges').click(function(e) {  
  var content = document.querySelector('input[name=body]');
  console.log(content);
  console.log(quill.getContents());
  content.value = JSON.stringify(quill.getContents());
  console.log(content);
});