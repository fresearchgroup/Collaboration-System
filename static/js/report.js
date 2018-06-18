$('document').ready(function(){
 $('#repo_submit').click(function(){

  var username = $('#username').val();
  var rid = $('#rid').val();
  var category = $('#category').val();
  var csrf = $('#csrf').val();
  var url = $('#url1').val();
  var status = '';

if ($( "#repo_submit" ).hasClass( "fa fa-flag-o" )){
     
     status = 'add';

}

if ($( "#repo_submit" ).hasClass( "fa fa-flag" )){
     
     status = 'remove';

}

  $.ajax({
    url: url,
    type: 'post',
    cache: false,
    data: { 'csrfmiddlewaretoken': csrf },
    data: {
    	'username' : username,
      'rid' : rid,
      'category' : category,
      'status' : status
    },
    success: function(data){

        if(data=='added'){
      	$('#repo_submit').removeClass('fa fa-flag-o');
        $('#repo_submit').addClass('fa fa-flag')
      } 
      if(data=='removed'){

            $('#repo_submit').removeClass('fa fa-flag');
            $('#repo_submit').addClass('fa fa-flag-o')
      }
    }
  });
 });		
});
