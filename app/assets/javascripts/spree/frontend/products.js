$( document).ready(function(){
  $('#carousel-product').carousel({
    interval: 30000
  });

  $('#variantTabs > .nav-tabs a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');

    /*
      Switch to appropriate picture when selecting a tab for a certain
      style.
    */
    var optionValueId = $(this).data('option-value-id');
    var image = $('#carousel-product .item[data-option-value-id="'+optionValueId+'"]');
    if (image.length) {
      var index = image.data('index');
      $('#carousel-product').carousel(parseInt(index));
    }
  });


  $("#carousel-product").swiperight(function() {
    $("#carousel-product").carousel('prev');
  });

  $("#carousel-product").swipeleft(function() {
    $("#carousel-product").carousel('next');
  });



  function updatePrice(e){
    $('#variant-price').attr('value', ($(e).attr('data-price')));
  }

  $('#variantTabs .btn-group input').hover(function(e) {
      $(this).siblings().css( {
        "background-color": "#ffffff",
        "color": "#000000"
      } );
    }, function() {
      $(this).siblings().removeAttr( 'style' );
    }
  );

  /*
      When loading the page or when changing a tab,
      select the first option, set the price, set variant_id
   */
  function initSelectedVariant(){
    if(parseInt($('#variant_id').attr('data-variant-count')) > 1) {
      $(".variants input").removeClass('active');
      $('.tab-pane.active input:first').addClass('active');
      updatePrice($('.tab-pane.active input:first'));
      $('#variant_id').val($('.tab-pane.active input:first').attr('id'))
    }
  }

  /*
      When clicking a variant, highlight it,
      set the price, and update the variant_id
   */
  $('.variant-button').click(function(e){
    updatePrice(this);
    $(".variants input").removeClass('active');
    $(this).addClass('active');
    $('#variant_id').val($(this).attr('id'))
  });

  $('#variantTabs a').click(function(e){
    initSelectedVariant();
  });

  initSelectedVariant();

    /*
     When loading the page, if the user is in a view less than 768, scroll down to product budy
     */
  function scrollToProductBody(){
    if( $(window).width() < 767) {
      $('html, body').animate({
        scrollTop: $("#product-images-and-options").offset().top
      }, 1);
    }
  }

    $("[data-target='#sizingModal']").on('click', function(e) {
        $(".sizing-guide[data-style-id='"+$(this).attr('data-style-id')+"']").show();
        $('#sizing-guide-style').text( $(this).attr('data-style-name') );
    });

    $('#sizingModal').on('hidden.bs.modal', function (e) {
        $('.sizing-guide').hide();
    });

  scrollToProductBody();

});