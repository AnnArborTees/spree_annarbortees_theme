module Spree
  class Stylesheet < ActiveRecord::Base
    has_and_belongs_to_many :stores, join_table: :spree_stores_stylesheets

    has_attached_file :logo, :styles => { :thumb => "100x100>" }
    has_attached_file :banner
    validates_attachment_content_type :logo,
                                      :content_type => /^image\/(png|gif)/, unless: ->{logo.blank?}
    validates_attachment_content_type :logo,
                                      :content_type => /^image\/(png|gif)/, unless: ->{banner.blank?}

    validates   :name, :banner_bg, :header_1_background_color, :header_1_color, :header_2_background_color,
                :header_2_color, :header_2_link_color, :product_background_color, :product_price_label_background_color,
                :product_price_label_color, :product_options_background_color, :product_options_option_background_color,
                :product_options_option_color, :layout_color_1, :layout_color_2, :layout_color_3, presence: true

    validates :name, uniqueness: true

    before_save :delete_images
    after_initialize :initialize_colors

    attr_accessor :destroy_banner, :destroy_logo

    def destroy_banner=(val)
      @destroy_banner=val
    end

    def destroy_logo(val)
      @destroy_logo=val
    end

    def rgb_for(attr)
      vals = send(attr).match /#(..)(..)(..)/
      {r: vals[1].hex, g: vals[2].hex, b: vals[2].hex}
    end

    def style_class
      name.downcase.gsub(' ', '-')
    end

    private

    def delete_images
      self.banner = nil if @destroy_banner
      self.logo = nil if @destroy_logo
    end

    def initialize_colors
      self.banner_bg = '#000000' unless self.banner_bg
      self.header_1_background_color = '#CBEAFC' unless self.header_1_background_color
      self.header_1_color = '#125e1d' unless self.header_1_color
      self.header_2_background_color = '#125e1d' unless self.header_2_background_color
      self.header_2_color = '#FFA509' unless self.header_2_color
      self.header_2_link_color = '#ffffff' unless self.header_2_link_color
      self.product_background_color = '#e1d9d6' unless self.product_background_color
      self.product_price_label_background_color = '#FFA509' unless self.product_price_label_background_color
      self.product_price_label_color = '#ffffff' unless self.product_price_label_color
      self.product_options_background_color = '#125e1d' unless self.product_options_background_color
      self.product_options_option_background_color = '#FFA509' unless self.product_options_option_background_color
      self.product_options_option_color = '#ffffff' unless self.product_options_option_color
      self.layout_color_1 = '#125e1d' unless self.layout_color_1
      self.layout_color_2 = '#000000' unless self.layout_color_2
      self.layout_color_3 =  'FFA509' unless self.layout_color_3
      self.layout_links_color = '#0c9378' unless self.layout_links_color
      self.leftnav_color_1 = '#FFA509' unless self.leftnav_color_1
      self.leftnav_color_2 = '#000000' unless self.leftnav_color_2
      self.leftnav_color_3 = '#125e1d' unless self.leftnav_color_3
      self.leftnav_background_color = '#EDEDEF' unless self.leftnav_background_color
    end


  end
end
