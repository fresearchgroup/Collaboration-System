var url = "/api/search/"

function delay(callback, ms) {
  var timer = 0;
  return function() {
    var context = this, args = arguments;
    clearTimeout(timer);
    timer = setTimeout(function () {
      callback.apply(context, args);
    }, ms || 0);
  };
}

$("#filter_query").keydown(delay(function (e) { 
    var query = $('#filter_query').val();
    var category = $('input[name=category]:checked').val();
                  $.ajax({
                          url: url+category,
                          type: 'GET',
                          cache: false,
                          data: { 'query': query },
                          success: function(data){
                              $("#results").empty();
                              for(i in data){
                                  desc = '';
                                  if(data[i]['desc']){desc = data[i]['desc'].substring(0, 300)}
                              var list = '<div class="infinite-item"><div class="row margin-bottom-15"><div class="col-md-2 col-sm-2"><object class="img-responsive" data="'+ data[i]['image'] + '" type="image/png"><img src="/media/default/community_image_default.png" alt="image" class="img-responsive"></object></div><div class="col-md-10 col-sm-10"><h3><a href="'+ data[i]['url'] + '"> ' + data[i]['title'] + '</a></h3><ul class="blog-info"><li><i class="fa fa-calendar"></i>'+ moment(data[i]['created_at']).format('MMMM Do YYYY, h:mm:ss a')+'</li><li><i class="fa fa-user"></i> '+ data[i]['created_by']+'</li></ul><p>'+ desc+'<a href="'+ data[i]['url'] + '" class="more">Read more <i class="icon-angle-right"></i></a></p></div></div><hr class="blog-post-sep"></div>'

                                $("#results").append(list);
                          }
                      }
              });
 
}, 500));