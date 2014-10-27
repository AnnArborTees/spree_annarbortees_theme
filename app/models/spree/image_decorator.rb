Spree::Image.class_eval do
  belongs_to :option_value

  validate :at_most_one_thumb_per_option_value

  attachment_definitions[:attachment][:styles] = {
      :mini => '48x48>', # thumbs under image
      :small => '400x400>', # images on category view
      :product => '450x450>', # full product image
      :large => '1000x1000>' # light box image
  }

  private

  def at_most_one_thumb_per_option_value
    # TODO: Make sure only one thumbnail per option value
  end
end
