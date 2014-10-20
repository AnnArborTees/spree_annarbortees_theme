Spree::StoreController.class_eval do

  def cart_count
    respond_to do |format|
      format.json do
        if simple_current_order.nil? or simple_current_order.item_count.zero?
          render text: 0
        else
          render text: simple_current_order.item_count
        end
      end
    end
    fresh_when(simple_current_order)
  end

end

# if simple_current_order.nil? or simple_current_order.item_count.zero?
#   text = "#{text}: (#{Spree.t('empty')})"
#   css_class = 'empty'
# else
#   text = "#{text}: (#{simple_current_order.item_count})  <span class='amount'>#{simple_current_order.display_total.to_html}</span>"
#   css_class = 'full'
# end
