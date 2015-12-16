Spree::CheckoutController.class_eval do
  def update_backorder_preference
    @order.update_attribute(:dont_split_packages_on_backorder, !@order.dont_split_packages_on_backorder)
    @order.create_proposed_shipments
    redirect_to checkout_state_path(:delivery), flash: {success: 'Successfully updated backorder preference' }    
  end
end
