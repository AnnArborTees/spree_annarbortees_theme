// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

//= require bootstrap/bootstrap
//= require holder
//= require jquery
//= require jquery-mobile
//= require_tree .

$('input[name=authenticity_token]').val($('meta[name=csrf-token]').attr('content'))