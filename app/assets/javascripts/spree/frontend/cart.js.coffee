$(document).ready ->
  ($ '.line-item .delete').click ->
    ($ this).parents('.line-item').first().find('input.line_item_quantity').val 0
    ($ this).parents('form').first().submit()
    false

  ($ '#empty-cart').click ->
    ($ 'input.line_item_quantity').val 0
    ($ this).parents('form').first().submit()
    false


  ($ '#update-quantities-link, #add-coupon-button').click ->
    ($ this).parents('form').first().submit()
    false

  $('a.remove-from-cart').one 'click', ->
    $(this).click ->
      false
    return