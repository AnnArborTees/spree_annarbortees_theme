Spree::CheckoutController.class_eval do
  include Devise::Controllers::SignInOut

  skip_before_filter :check_registration, only: [:update, :edit, :check_email]

  def check_email
    raise "No order present" if @order.blank?
    @email = params[:user_email]
    @order.update_column :email, @email
    respond_to(&:js)
  end

  def assign_user
    raise "No order present" if @order.blank?
    return if @order.email.blank?

    pass = ->x{ params[x].is_a?(Array) ? params[x].first : params[x] }

    if pass[:password] && pass[:password_confirmation]
      @user = Spree::User.create(
        email: @order.email,
        password: pass[:password],
        password_confirmation: pass[:password_confirmation]
      )
    elsif pass[:password]
      @user = Spree::User.find_by(email: @order.email)

      unless @user && @user.valid_password?(pass[:password])
        @user = nil
      end
    end

    if @user && @user.persisted?
      sign_in @user and @order.update_column :user_id, @user.id
    end
  end

  # Updates the order and advances to the next state (when possible.)
  # (Slightly modified copy/paste from spree/spree)
  def update
    # Hold onto shipping rates by name if possible
    if params[:steps] && params[:steps].include?('delivery')
      @selected_rate_names = @order.shipments.map { |s| s.selected_shipping_rate.name }
    end

    if @order.update_from_params(params, permitted_checkout_attributes)
      persist_user_address
      unless @order.next
        flash[:error] = @order.errors.full_messages.join("\n")
        redirect_to_state and return
      end

      # Restore shipping rates by name if possible
      if @selected_rate_names
        @order.shipments.each_with_index do |shipment, i|
          rate = shipment.shipping_rates.find { |r| r.name == @selected_rate_names[i] }
          shipment.selected_shipping_rate_id = rate.id if rate
        end
        # Advance order state again since shipping has been selected already
        @order.next
      end

      if @order.completed?
        session[:order_id] = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        checkout_complete
      else
        redirect_to_state
      end
    else
      render :edit
    end
  end

  def update_backorder_preference
    @order.update_attribute(:dont_split_packages_on_backorder, !@order.dont_split_packages_on_backorder)
    @order.create_proposed_shipments
    respond_to do |format|
      format.html do
        redirect_to checkout_state_path(:delivery), flash: {success: 'Successfully updated backorder preference' }    
      end
      format.js { params[:steps] = 'delivery' and render 'edit' }
    end
  end

  protected

  def redirect_to_state
    respond_to do |format|
      format.html { redirect_to checkout_state_path(@order.state) }
      format.js { render :edit }
    end
  end

  def checkout_complete
    respond_to do |format|
      format.html { redirect_to completion_route }
      format.js { @completion_route = "#{request.base_url}#{completion_route}"; render :complete }
    end
  end
end
