// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(document).ready(function(){
    $('.stylesheet-input').change(function(e){
        if( $(this).attr('id') == 'stylesheet_banner_bg') {
            $('.homepage-banner').css('background-color', $(this).val());
        } else if ( $(this).attr('id') == 'stylesheet_header_1_background_color' ) {
            $('.header-1').css('background-color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_header_1_color' ) {
            $('.header-1').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_header_2_background_color' ) {
            $('.header-2').css('background-color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_header_2_color' ) {
            $('.header-2').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_header_2_link_color' ) {
            $('.header-2 a:link').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_product_background_color' ) {
            $('.product-image').css('background-color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_product_price_label_background_color' ) {
            $('.product-price').css('background-color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_product_price_label_color' ) {
            $('.product-price').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_product_options_background_color' ) {
            $('.product-option-box').css('background-color', $(this).val());
            $('.btn-inactive').css('background-color', $(this).val());
            $('.product-option-tab li.active').css('background-color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_product_options_option_background_color' ) {
            $('.btn-active').css('background-color', $(this).val());
            $('.product-option-tab li.inactive').css('background-color', $(this).val());
            $('.btn-active').css('border-color', $(this).val());
            $('.btn-inactive').css('border-color', $(this).val());
            $('.btn-buy').css('border-color', $(this).val());
            $('.btn-buy').css('background-color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_product_options_option_color' ) {
            $('.btn-inactive').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_leftnav_color_1' ) {
            $('.left-nav h2').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_leftnav_color_2' ) {
            $('.left-nav h3').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_leftnav_color_3' ) {
            $('.left-nav li').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_layout_color_1' ) {
            $('.layout-body h3').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_layout_color_2' ) {
            $('.layout-body p').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_layout_color_3' ) {
            $('.').css('color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_leftnav_background_color' ) {
            $('.left-nav').css('background-color', $(this).val());

        } else if ( $(this).attr('id') == 'stylesheet_layout_links_color' ) {
            $('.layout-body a:link, .layout-body a:active').css('color', $(this).val());

        }
    })
});