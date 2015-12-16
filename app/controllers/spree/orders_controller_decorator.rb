Spree::OrdersController.class_eval do

  def update_backorder_preference
    current_order.update_attribute(:dont_split_packages_on_backorder, !current_order.dont_split_packages_on_backorder)
    setup_for_current_state
    redirect_to checkout_state_path(current_order.state), flash: {success: 'Successfully updated backorder preference' }    
  end

  private

  def order_params
    if params[:order]
      params[:order].permit(*permitted_order_attributes + [:dont_split_packages_on_backorder])
    else
      {}
    end
  end

end
