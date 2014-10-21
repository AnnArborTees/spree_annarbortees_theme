Spree::OrdersController.class_eval do
  before_filter :clear_cache, only: [:populate, :update, :empty]

  private

  def clear_cache
    expire_fragment [@order, current_store]
  end

end