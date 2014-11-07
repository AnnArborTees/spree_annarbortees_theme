Spree::CheckoutControllerDecorator.class_eval do

  private

  def completion_route
    spree.order_path(@order, checkout_complete: true)
  end

end