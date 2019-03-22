$(function () {
    console.log("Hiiiiiiiii")
    'use strict';

    $('#q').autocomplete({
    serviceUrl: "http://127.0.0.1:8000/search/autocomplete/",
    minChars: 2,
    dataType: 'json',
    type: 'GET',
    onSelect: function (suggestion) {
        console.log("testing......")
        console.log( suggestion.value + ', data :' + suggestion.data);
    }
});

});

function getParameterByName(name, url) {
    if (!url) {
      url = window.location.href;
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}




function onFacetChangeApplied(){

    var url = window.location.href.split("?")[0];
    var search_query = getParameterByName('q');
    var community_query = getParameterByName('community');
    var article_query = getParameterByName('article');
    var image_query = getParameterByName('image');
    var audio_query = getParameterByName('audio');
    var video_query = getParameterByName('video');
    if (community_query !== null){
        community_query = "&community=community"
    }
    else{
        community_query = ""
    }
    if (article_query !== null){
        article_query = "&article=article"
    }
    else{
        article_query = ""
    }
    if (image_query !== null){
        image_query = "&image=image"
    }
    else{
        image_query = ""
    }
    if (audio_query !== null){
        audio_query = "&audio=audio"
    }
    else{
        audio_query = ""
    }
    if (video_query !== null){
        video_query = "&video=video"
    }
    else{
        video_query = ""
    }
	var url_with_search_query = url + '?q=' + search_query + community_query + audio_query + article_query + video_query + image_query 
	$('input:checkbox.facet').each(function () {
    	var sThisVal = (this.checked ? $(this).val() : null);
        var sThisName = (this.checked ? $(this).attr('name') : null);
        if(sThisVal !== null){
        	url_with_search_query += '&'+encodeURIComponent(sThisName)+'='+encodeURIComponent(sThisVal);
        }
    });
	location.href = url_with_search_query;
	return true;
}    


function getQueryParams(){
    var vars = {}, hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars[hash[1]] = hash[0] ;
    }
    return vars;
}


$( document ).ready(function() {
	var all_params = getQueryParams();
	$.each( all_params, function( key, value ) {
		id = decodeURIComponent(key).replace(/\s/g,'');
		$('#'+id).attr('checked', 'checked');
        if (value == 'q'){
            $('#q').attr("value",key);
        }
		});
	
});