(function($){
$(document).ready(function ($) {
    $('.timer').countTo();
    $('.counter-item').appear(function() {
        $('.timer').countTo();
    },{accY: -100});
});

}(jQuery));
