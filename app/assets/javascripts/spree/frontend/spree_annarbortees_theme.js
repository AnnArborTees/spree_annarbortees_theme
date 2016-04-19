// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

//= require bootstrap/bootstrap
//= require holder
//= require jquery
//= require jquery-mobile
//= require imagesloaded
//= require spin
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

    if ($('#checkout').length > 0) {
      // Utility function for managing spinners
      var spinOn = function(target) {
        var spinner;
        if (target.data('spinner') == null) {
          spinner = new Spinner();
          target.data('spinner', spinner);
        }
        else {
          spinner = target.data('spinner');
        }

        target.each(function() { spinner.spin(this); });
      };

      // Use this to submit a step form
      window.submitStepFrom = function(from) {
        var form = from.closest('form');
        var affectedStep = form.find('input[name=steps]').val();
        var affectedForm;
        if (affectedStep != null) {
          affectedForm = $("#checkout_"+affectedStep).find('.panel');
        }

        // All of the adjustments here are undone in app/views/spree/checkout/edit.js.erb
        if (affectedForm)
          affectedForm.addClass('checkout-loading');
        var checkoutSummary = $('#checkout-summary-content');
        checkoutSummary.addClass('checkout-loading');
        spinOn(checkoutSummary);

        form.submit();
      };

      // Changing address submits the address step if all required fields are in
      var requiredFields = 'input.required,select.required';
      window.reloadDeliveryStep = function() {
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

        window.submitStepFrom(inner);
      }

      window.reloadShippingTimer = null;
      $(document).on('input', '.address-form input,.address-form select', function() {
        if (reloadShippingTimer != null) {
          clearTimeout(reloadShippingTimer);
          reloadShippingTimer = null;
        }
        reloadShippingTimer = setTimeout(window.reloadDeliveryStep.bind(this), 700);
      });

      // Changing shipping method submits shipment step
      $(document).on('change', '.shipping-methods input', function() {
        window.submitStepFrom($(this));
      });

      // Place order by submitting payment step
      $(document).on('click', '#place-order-button', function() {
        window.submitStepFrom($('#payment'));
      });
    }
});

// Hide/show shipping address form based on "use billing address" checkbox
window.useBillingAddressCheckbox = function() {
  var orderUseBilling = $('#order_use_billing');
  if (orderUseBilling.length > 0) {
    var hideShippingAddress = function() {
      var modClass;
      if (this.checked)
        modClass = 'addClass';
      else
        modClass = 'removeClass';

      $(this).closest('.panel-body').find('[data-hook="shipping_inner"]')[modClass]("hidden");
    };

    orderUseBilling.on('change', function() {
      hideShippingAddress.apply(this);

      if (this.checked)
        window.reloadDeliveryStep.apply($('#bfirstname')[0]);
      else
        window.reloadDeliveryStep.apply($('#sfirstname')[0]);
    });
    hideShippingAddress.apply(orderUseBilling[0]);
  }
  else
    console.log('not doin it');
};
