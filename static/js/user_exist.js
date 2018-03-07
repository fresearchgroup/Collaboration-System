$('document').ready(function(){
 $('#username').on('blur', function(){
  var username = $('#username').val();
  var form = $(this).closest("form");
  if (username == '') {
    $('#username').siblings("span#check").text('');
    $('#username').siblings("span#check2").text('');
    return;
  }
  $.ajax({
    url: form.attr("data-validate-username-url"),
    type: 'get',
    cache: false,
    data: { 'csrfmiddlewaretoken': '{{csrf_token}}' },
    data: {
    	'username' : username,
    },
    success: function(data){
      if (data.is_taken) {
      	$('#username').parent().removeClass();
      	$('#username').parent().addClass("form_error");
      	$('#username').siblings("span#check2").text('Sorry Username is taken');
        $('#username').siblings("span#check").text('');
        $('#submit').prop('disabled', True);
      }else {
      	$('#username').parent().removeClass();
      	$('#username').parent().addClass("form_success");
      	$('#username').siblings("span#check").text('Username available');
        $('#username').siblings("span#check2").text('');
      }
    }
  });
 });		
});


