var allow_reputation_stat_update = true;
var user_log = {};

function updateReputationStat(update_type, reason) {
  if (!allow_reputation_stat_update) return;
  allow_reputation_stat_update = false;

  var updates = { 
    resource_type: resource_type,
    update_type: update_type,
    reason: reason
  };

  $.ajax({
    url: '/api/reputation/reputation_stats/' + id + '/?resource_type=' + resource_type,
    type: 'POST',
    data: updates,
    beforeSend: function(xhr) {
      xhr.setRequestHeader('X-CSRFToken', Cookies.get('csrftoken'))
    },
    success: function(data) {
      updateStats(data); 
    },
    error: () => {
      allow_reputation_stat_update = true;
      swal({
        title: 'Server not responding. Please try again.'
      })
    }
  });
}

$(document).ready(function() {
  $.ajax({
    url: '/api/reputation/reputation_stats/' + id + '/?resource_type=' + resource_type,
    type: 'GET',
    success: function(data) {
      updateStats(data);
    }
  })
});

function updateStats(data) {
  user_log = data['user_log'];
  $('#reputation-upvote').toggleClass('fa-thumbs-o-up', !user_log.upvoted);
  $('#reputation-downvote').toggleClass('fa-thumbs-o-down', !user_log.downvoted);
  $('#reputation-reported').toggleClass('fa-flag-o', !user_log.reported);

  $('#reputation-upvote').toggleClass('fa-thumbs-up', user_log.upvoted);
  $('#reputation-downvote').toggleClass('fa-thumbs-down', user_log.downvoted);
  $('#reputation-reported').toggleClass('fa-flag', user_log.reported);    

  var resource_log = data['resource_log'];

  $('.upvote-count').text(resource_log.upvote);
  $('.downvote-count').text(resource_log.downvote);
  $('.reported-count').text(resource_log.reported);

  allow_reputation_stat_update = true;
}
