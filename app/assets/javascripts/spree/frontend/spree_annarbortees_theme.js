// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

//= require bootstrap/bootstrap
//= require holder
//= require jquery
//= require jquery-mobile
//= require masonry
//= require spree/frontend/bootstrap/youtubepopup
//= require_tree .

$('input[name=authenticity_token]').val($('meta[name=csrf-token]').attr('content'))

$(function() {
    $('a[href*=#]:not([href=#])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
                $('html,body').animate({
                    scrollTop: target.offset().top - 100
                }, 500);
                return false;
            }
        }
    });
});
