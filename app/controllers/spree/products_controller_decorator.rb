Spree::ProductsController.class_eval do
  before_filter :load_option_data, only: :show

  private

  def load_option_data
      if @product.layout == 'imprinted_apparel'
        @styles = @product.option_values_for_option_type(Spree::OptionType.find_by(name: 'apparel-style'))
        @sizing_guides = find_sizing_guides_for_styles(@styles)
      end
  end

  def find_sizing_guides_for_styles(styles)
    sizing_guides = {}
    styles.each do |style|
      if Spree::SizingGuide.friendly.exists?(format_style_name_for_sizing_guide_slug(style.presentation))
        sizing_guide = Spree::SizingGuide.friendly.find(format_style_name_for_sizing_guide_slug(style.presentation))
        sizing_guides[style.id] = sizing_guide
      end
    end
    sizing_guides
  end

  def format_style_name_for_sizing_guide_slug(presentation)
    presentation.gsub("'", "-").gsub(" ", "-").downcase
  end

end