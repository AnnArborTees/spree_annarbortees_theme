$(document).ready(function(){
    $('.carousel-homepage').carousel();

    $.ajax({
        url: '/cart_count',
        success: function(data) {
            return $('.cart-count').html(data);
        }
    });

    $('.products').imagesLoaded(function(){
        $('.products').masonry({
            itemSelector: '.product'
        });
    });

});