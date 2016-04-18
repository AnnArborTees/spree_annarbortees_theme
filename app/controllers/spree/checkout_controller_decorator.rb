Spree::CheckoutController.class_eval do
  # Updates the order and advances to the next state (when possible.)
  # (Unaltered copy/paste from spree/spree)
  def update
    if @order.update_from_params(params, permitted_checkout_attributes)
      persist_user_address
      unless @order.next
        flash[:error] = @order.errors.full_messages.join("\n")
        redirect_to checkout_state_path(@order.state) and return
      end

      if @order.completed?
        session[:order_id] = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        redirect_to completion_route
      else
        redirect_to checkout_state_path(@order.state)
      end
    else
      render :edit
    end
  end

  def update_backorder_preference
    @order.update_attribute(:dont_split_packages_on_backorder, !@order.dont_split_packages_on_backorder)
    @order.create_proposed_shipments
    redirect_to checkout_state_path(:delivery), flash: {success: 'Successfully updated backorder preference' }    
  end
end
