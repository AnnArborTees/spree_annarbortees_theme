Spree::ProductsHelper.class_eval do

  # converts line breaks in product description into <p> tags (for html display purposes)
  def product_description(product)
    if product.description.blank?
      'No description provided'
    elsif Spree::Config[:show_raw_product_description]
      raw(product.description)
    else
      raw(product.description.gsub(/(.*?)\r?\n\r?\n/m, '<p>\1</p>'))
    end
  end

  def should_be_active?(style, index)
    return index == 0 unless @variant

    @variant.option_values.include?(style)
  end

  def tweet_headline(product)
    if product.tweets.empty?
      'Start the conversation'
    else
      'Join the conversation'
    end
  end
end