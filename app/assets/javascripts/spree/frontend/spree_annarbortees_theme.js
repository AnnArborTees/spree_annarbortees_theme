// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

//= require bootstrap/bootstrap
//= require holder
//= require jquery
//= require jquery-mobile
//= require imagesloaded
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

    function isTouchDevice(){
        return true == ("ontouchstart" in window || window.DocumentTouch && document instanceof DocumentTouch);
    }

    if(isTouchDevice()===false) {
        $('[data-toggle="tooltip"]').tooltip();
    }

    // Selecting a country reloads the shipping step
    var requiredFields = 'input.required,select.required';
    var reloadDeliveryStep = function() {
      console.log('reloadDeliveryStep enter');
      var inner = $(this).closest('.address-form');
      var addressType = inner.data('address-type');

      if (addressType == null || (addressType === 'billing' && !$('.use-billing')[0].checked)) {
        console.log("bailing.");
        if (inner.length === 0)
          console.log("no inner");
        console.log("I'm "+$(this).prop('id'));
        return;
      }

      var field = function(attr) { return inner.find('.address-'+attr).val(); };

      var formComplete = true;
      inner.find(requiredFields).each(function() {
        if ($(this).val() == '')
          formComplete = false;
      });
      if (!formComplete) {
        console.log('shipping address form not complete');
        return;
      }
      console.log('querying for shipping');

      shipping_address = {
        firstname:  field('firstname'),
        lastname:   field('lastname'),
        address1:   field('address1'),
        address2:   field('address2'),
        city:       field('city'),
        zipcode:    field('zipcode'),
        state_name: field('state_name'),
        company:    field('company'),
        state_id:   field('state_id'),
        country_id: field('country_id'),
        phone:      field('phone'),
        alternative_phone: field('alternative_phone'),
      };

      $.ajax({
        url:      "/checkout",
        method:   "GET",
        dataType: "script",
        data: {
          step: "delivery",
          shipping_address: shipping_address
        }
      });
    }
    window.reloadShippingTimer = null;
    $('.address-form '+requiredFields).on('input', function() {
      if (reloadShippingTimer != null) {
        clearTimeout(reloadShippingTimer);
        reloadShippingTimer = null;
      }
      reloadShippingTimer = setTimeout(reloadDeliveryStep.bind(this), 700);
    });

    // Hide/show shipping address form based on "use billing address" checkbox
    var orderUseBilling = $('#order_use_billing');
    if (orderUseBilling.length > 0) {
      orderUseBilling.on('change', function() {
        var modClass;
        if (this.checked) {
          modClass = 'addClass';
          reloadDeliveryStep.apply($('#bfirstname')[0]);
        }
        else {
          modClass = 'removeClass';
          reloadDeliveryStep.apply($('#sfirstname')[0]);
        }

        $(this).closest('.panel-body').find('[data-hook="shipping_inner"]')[modClass]("hidden");
      });
      orderUseBilling.trigger('change');
    }
});
