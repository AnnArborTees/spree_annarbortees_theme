// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

//= require bootstrap/bootstrap
//= require holder
//= require jquery
//= require jquery-mobile
//= require imagesloaded
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

    $('#search-keywords').focusin(function() {
      $('#search-dropdown').show();
    });

    $('#search-keywords').keyup(function(){
        $('.search-text').html($(this).val());
    });


    var timer;

    $('#search-keywords, #search-dropdown-wrapper, #large-search').mouseleave(function(){
        timer = setTimeout(hideAndDeselect, 2000);
    }).mouseenter(function() {
        clearTimeout(timer);
    });

    function hideAndDeselect(){
        $('#search-dropdown').hide()
        $('#search-keywords').blur()
    }

    var store_index = 0;
    function move_search_store_to(new_index) {
      var $selection = $('.store-search-selection[data-index='+new_index+']');
      if ($selection.length == 0) { return; }

      var $old_selection = $('.store-search-selection[data-index='+store_index+']');
      store_index = new_index;
      var $search_store = $('#search-store');
      var store_val = $selection.data('store');
      if (store_val === '') {
        $search_store.attr('disabled', true);
      } else {
        $search_store.attr('disabled', false);
        $search_store.val(store_val);
      }

      $selection.addClass('search-selected');
      $old_selection.removeClass('search-selected');
    }

    $('#search-keywords').keydown(function(event) {
      var direction = 0;
      switch (event.which) {
        case 38: // up
          direction = -1;
          break;
        case 40: // down
          direction = 1;
          break;
      }
      if (direction === 0) { return; }
      event.preventDefault();

      move_search_store_to(store_index + direction);
    });

    $('.store-search-selection').click(function() {
      var index = $(this).data('index');
      if (store_index != index) {
        move_search_store_to(index);
      }
    });

    $('[data-toggle="tooltip"]').tooltip();
});
