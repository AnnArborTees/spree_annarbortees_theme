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
end