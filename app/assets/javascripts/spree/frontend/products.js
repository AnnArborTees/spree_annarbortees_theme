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

    $(".icon-prev").click(function() {
        $("#carousel-product").carousel('prev');
    });

  $(".icon-next").click(function() {
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

  $('#buy-button input[type=submit]').click(function() {
    if (!$('.variants').length == 0) {
      if ($('.variants input.active').length <= 0) {
        alert("Please select a variant to add to your cart!");
        return false;
      }
    }
  });

  /*
      When loading the page or when changing a tab,
      select the first option, set the price, set variant_id
   */
  function initSelectedVariant(){
    if(parseInt($('#variant_id').data('variant-count')) > 0) {
      $(".variants input").removeClass('active');
      $('.tab-pane.active input:first').addClass('active');
      updatePrice($('.tab-pane.active input:first'));
      if (!$('#variant_id').data('no-variants'))
        $('#variant_id').val($('.tab-pane.active input:first').attr('id'));
    }
  }

  /*
      When clicking a variant, highlight it,
      set the price, and update the variant_id
   */
  $('.variant-button').click(function(e){
    updatePrice(this);
    $(".variants input, .digital-variants input").removeClass('active');
    $(this).addClass('active');
    $('#variant_id').val($(this).attr('id'))
  });

  $('#variantTabs a').click(function(e){
    initSelectedVariant();
  });

  if ($(".variants input.active").length <= 0) {
    // console.log("initting selected variant");
    initSelectedVariant();
  }


    $("[data-target='#sizingModal']").on('click', function(e) {
        $(".sizing-guide[data-style-id='"+$(this).attr('data-style-id')+"']").show();
        $('#sizing-guide-style').text( $(this).attr('data-style-name') );
    });

    $('#sizingModal').on('hidden.bs.modal', function (e) {
        $('.sizing-guide').hide();
    });


  $(".youtube").YouTubeModal(youTubeModalOptions());

  function youTubeModalOptions() {
      var width;
      var w = window.innerWidth;

      if(w < 640) {
          width = w - 40;
      } else {
          width = 640;
      }
      var height = 480.0 / 640.0 * width;
      return({autoplay:1, width:width, height:height});
  }

});
