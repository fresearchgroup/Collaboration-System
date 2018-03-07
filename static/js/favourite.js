$('document').ready(function(){
 $('#fav_submit').click(function(){

  var username = $('#username').val();
  var rid = $('#rid').val();
  var category = $('#category').val();
  var csrf = $('#csrf').val();
  var url = $('#url').val();
  var status = '';

if ($( "#fav_submit" ).hasClass( "fa fa-star-o" )){
     
     status = 'add';

}

if ($( "#fav_submit" ).hasClass( "fa fa-star" )){
     
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
      	$('#fav_submit').removeClass('fa fa-star-o');
        $('#fav_submit').addClass('fa fa-star')
      } 
      if(data=='removed'){

            $('#fav_submit').removeClass('fa fa-star');
            $('#fav_submit').addClass('fa fa-star-o')
      }
    }
  });
 });		
});
