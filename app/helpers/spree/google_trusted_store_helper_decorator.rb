if defined? Spree::GoogleTrustedStoreHelper
  Spree::GoogleTrustedStoreHelper.class_eval do

    private

    def digital_in?(order)
      order.some_digital?
    end

  end
end
