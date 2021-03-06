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
          affectedForm = $("#checkout_form_"+affectedStep).find('.panel');
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
      var requiredFields = "[name$='[address1]'],[name$='[city]'],[name$='[country_id]'],[name$='[zip]']";
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

      const inputDelay = 1200;

      window.reloadShippingTimer = null;
      $(document).on('input', '.address-form input,.address-form select', function() {
        if (window.reloadShippingTimer != null) {
          clearTimeout(window.reloadShippingTimer);
          window.reloadShippingTimer = null;
        }
        window.reloadShippingTimer = setTimeout(window.reloadDeliveryStep.bind(this), inputDelay);
      });

      // Changing shipping method submits shipment step
      $(document).on('change', '.shipping-methods input', function() {
        window.submitStepFrom($(this));
      });

      // Place order by submitting payment step
      $(document).on('click', '#place-order-button', function() {
        var userForm = $('#checkout-assign-user-form');
        if (userForm.length > 0) {
          var checkoutSummary = $('#checkout-summary-content');
          checkoutSummary.addClass('checkout-loading');
          spinOn(checkoutSummary);

          userForm.submit();
        }
        else {
          window.submitStepFrom($('#payment'));
        }
      });

      // Assign email to order here
      window.checkEmailTimer = null;
      $(document).on('change', '#checkout-order-email input', function() {
        if (window.checkEmailTimer != null) {
          clearTimeout(window.checkEmailTimer);
          window.checkEmailTimer = null;
        }

        var form = $(this).closest('form');
        window.checkEmailTimer = setTimeout(function() { form.submit(); }, inputDelay / 2);
      });

      // Reload delivery button just submits the address form again
      $(document).on('click', '#reload-delivery-step', function(event) {
        if ($('#order_use_billing').length > 0 && $('#order_use_billing')[0].checked)
          window.reloadDeliveryStep.apply($('#bfirstname')[0]);
        else
          window.reloadDeliveryStep.apply($('#sfirstname')[0]);

        event.preventDefault();
        return false;
      });

      // Reload on page load if the current step is address or somehow cart
      var orderState = $('#checkout').data('step');
      if (orderState === 'cart' || orderState === 'address') {
        window.setTimeout(function() {
          console.log("doing it");
          if ($('#order_use_billing').length > 0 && $('#order_use_billing')[0].checked)
            window.reloadDeliveryStep.apply($('#bfirstname')[0]);
          else
            window.reloadDeliveryStep.apply($('#sfirstname')[0]);
        }, 100);
      }
    }
});

// Reload delivery when billing address=shipping address is changed
window.useBillingAddressCheckbox = function() {
  var orderUseBilling = $('#order_use_billing');
  if (orderUseBilling.length > 0) {
    orderUseBilling.on('change', function() {
      if (this.checked)
        window.reloadDeliveryStep.apply($('#bfirstname')[0]);
      else
        window.reloadDeliveryStep.apply($('#sfirstname')[0]);
    });
  }
  else
    console.log('not doin it');
};
