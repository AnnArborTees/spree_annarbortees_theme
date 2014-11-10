$(document).ready(function(){
    $('.carousel-homepage').carousel();

    $.ajax({
        url: '/cart_count',
        success: function(data) {
            return $('.cart-count').html(data);
        }
    });

    $('.products').masonry({
        itemSelector: '.product'
    });
});