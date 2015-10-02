module Spree
  module Admin
    class StylesheetsController < ResourceController
      update.before :set_stores

      def index
        @stylesheets = Spree::Stylesheet.all
      end

      private

      def permitted_stylesheets_attributes
        [:name, :banner_bg, :header_1_background_color, :header_1_color, :header_2_background_color,
         :header_2_color, :header_2_link_color, :product_background_color, :product_price_label_background_color,
         :product_price_label_color, :product_options_background_color, :product_options_option_background_color,
         :product_options_option_color, :layout_color_1, :layout_color_2, :layout_color_3, :leftnav_color_1,
         :leftnav_color_2, :leftnav_color_3, :layout_links_color, :logo, :banner, :hide_banner_text, {store_ids: []}]
      end

      def set_stores
        @stylesheet.store_ids = nil unless params[:stylesheet].key? :store_ids
      end
    end
  end
end
