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

function onFacetChangeApplied(){

    var url = window.location.href.split("?")[0];
    var all_params = getQueryParams();
    var url_with_search_query = url + "?";
    var first_param = false;
    $.each( all_params, function( key, value ) {
        id = decodeURIComponent(key).replace(/\s/g,'');
        if (first_param == true){
            url_with_search_query += "&"
        }
        url_with_search_query += encodeURIComponent(value) + "=" + encodeURIComponent(key);
        first_param = true;
    });
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

$( document ).ready(function() {
	var all_params = getQueryParams();
	$.each( all_params, function( key, value ) {
		id = decodeURIComponent(key).replace(/\s/g,'');
		$('#'+id).attr('checked', 'checked');
        if (value == 'q' || value == 'q1'){
            var query_id = value;
            $('#'+query_id).attr("value",key);
        }
		});
	
});