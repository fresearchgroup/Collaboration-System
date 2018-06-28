// $('document').ready(function(){
//  $('#submitreason').click(function(){
       
//   var username = $('#username').val();
//   var rid = $('#rid').val();
//   var category = $('#category').val();
//   var csrf = $('#csrf').val();
//   var url = $('#url1').val();
//   var status = '';
//   var reason = '';


// if ($( "i[name=repo_submit]" ).hasClass( "fa fa-flag-o" )){
//      alert("ASd");
//      alert(url);
//      status = 'add';
//      reason = $('#option').val()
//     //  do{
//     // reason = prompt("1.Discrimination\n2.Harrassment\n3.Vague\n4.Article not related\n5.Plagarism\n6.Outdated Information\n7.Poorly written\n8.Factually Incorrect\nEnter a valid option.");
//     // if(reason === null){
//     //   return;
//     // }
//     // reason = Number(reason)
//     // if(!isNaN(reason)){
//     //   reason = parseInt(reason,10)
//     // }
//     // }while(reason < 1 || reason > 8  || isNaN(reason));
//     // if(reason == 1){
//     //   reason = 'Discrimination';
//     // }else if(reason == 2){
//     //   reason = 'Harrassment';
//     // }else if(reason == 3){
//     //   reason = 'Vague';
//     // }else if(reason == 4){
//     //   reason = 'Article not related';
//     // }else if(reason == 5){
//     //   reason = 'Plagarism';
//     // }else if(reason == 6){
//     //   reason = 'Outdated Information';
//     // }else if(reason == 7){
//     //   reason = 'Poorly written';
//     // }else{
//     //   reason = 'Factually Incorrect';
//     // }

// }

// if ($( "i[name=repo_submit]" ).hasClass( "fa fa-flag" )){
//      status = 'remove';
//      reason = ''
// }

//   $.ajax({
//     url: url,
//     type: 'post',
//     cache: false,
//     data: { 'csrfmiddlewaretoken': csrf },
//     data: {
//     	'username' : username,
//       'rid' : rid,
//       'category' : category,
//       'status' : status,
//       'reason' : reason
//     },
//     success: function(data){
//       alert(data);
//         if(data=='added'){
//       	$('i[name=repo_submit]').removeClass('fa fa-flag-o');
//         $('i[name=repo_submit]').addClass('fa fa-flag')
//       } 
//       if(data=='removed'){

//             $('i[name=repo_submit]').removeClass('fa fa-flag');
//             $('i[name=repo_submit]').addClass('fa fa-flag-o')
//       }
//     }
//   });
//  });		
//   // $('#repo_submit').click(function(){
       
//   // var username = $('#username').val();
//   // var rid = $('#rid').val();
//   // var category = $('#category').val();
//   // var csrf = $('#csrf').val();
//   // var url = $('#url1').val();
//   // var status = '';
//   // var reason = '';
//   // if ($( "#repo_submit" ).hasClass( "fa fa-flag" )){
//   //    status = 'remove';
//   //    reason = ''
//   // }
//   // $.ajax({
//   //   url: url,
//   //   type: 'post',
//   //   cache: false,
//   //   data: { 'csrfmiddlewaretoken': csrf },
//   //   data: {
//   //     'username' : username,
//   //     'rid' : rid,
//   //     'category' : category,
//   //     'status' : status,
//   //     'reason' : reason
//   //   },
//   //   success: function(data){
//   //       alert(data);
//   //       if(data=='added'){
//   //       $('i[name=repo_submit]').removeClass('fa fa-flag-o');
//   //       $('i[name=repo_submit]').addClass('fa fa-flag')
//   //     } 
//   //     if(data=='removed'){

//   //           $('i[name=repo_submit]').removeClass('fa fa-flag');
//   //           $('i[name=repo_submit]').addClass('fa fa-flag-o')
//   //     }
//   //   }
//   // });
//   // });
// });

function CheckReason(val){
 var element=document.getElementById('reasontext');
 if(val=='Others'){
   element.style.display='block';
   element.setAttribute("required", "");
 }
 else{  
   element.style.display='none';
   element.removeAttribute("required");
}
}
