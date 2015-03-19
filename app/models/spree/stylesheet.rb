module Spree
  class Stylesheet < ActiveRecord::Base
    has_and_belongs_to_many :stores, join_table: :spree_stores_stylesheets

    validates   :name, :banner_bg, :header_1_background_color, :header_1_color, :header_2_background_color,
                :header_2_color, :header_2_link_color, :product_background_color, :product_price_label_background_color,
                :product_price_label_color, :product_options_background_color, :product_options_option_background_color,
                :product_options_option_color, :layout_color_1, :layout_color_2, :layout_color_3, presence: true

    validates :name, uniqueness: true

    after_initialize :initialize_colors

    private

    def initialize_colors
      self.banner_bg = '000000'
      self.header_1_background_color = 'CBEAFC'
      self.header_1_color = '125e1d'
      self.header_2_background_color = '125e1d'
      self.header_2_color = 'FFA509'
      self.header_2_link_color = 'ffffff'
      self.product_background_color = 'e1d9d6'
      self.product_price_label_background_color = 'FFA509'
      self.product_price_label_color = 'ffffff'
      self.product_options_background_color = '125e1d'
      self.product_options_option_background_color = 'FFA509'
      self.product_options_option_color = 'ffffff'
      self.layout_color_1 = '125e1d'
      self.layout_color_2 = '000000'
      self.layout_color_3 =  'FFA509'
    end


  end
end
