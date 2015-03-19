/*
 *= require jquery.minicolors
 *= require spree/backend/stylesheets
 */

$( document).ready(function(){
    $("#product_layout").change(function(e){
        if ( $(this).val() == 'digital_download' ) {
            $("[data-hook='admin_product_digital_preview']").show();
        } else {
            $("[data-hook='admin_product_digital_preview'").hide();
        }
    })

    $('input.color-picker').minicolors()
});