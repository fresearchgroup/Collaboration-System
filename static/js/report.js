$('document').ready(function(){
 $('#repo_submit').click(function(){

  var username = $('#username').val();
  var rid = $('#rid').val();
  var category = $('#category').val();
  var csrf = $('#csrf').val();
  var url = $('#url1').val();
  var status = '';
  var reason = '';

if ($( "#repo_submit" ).hasClass( "fa fa-flag-o" )){
     
     status = 'add';
     do{
    reason = prompt("What's the reason? Keep it Short !");
    }while(reason == null || reason == "" );

}

if ($( "#repo_submit" ).hasClass( "fa fa-flag" )){
     
     status = 'remove';
     reason = ''

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
      'status' : status,
      'reason' : reason
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
