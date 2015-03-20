require 'uri'

Spree::BaseHelper.class_eval do

  def theme_class(store)
    return 'default' if store.stylesheets.empty?
    return store.stylesheets.first.style_class unless store.stylesheets.empty?
  end

  def theme_logo_path(store)
    return store.stylesheets.first.logo.url unless store.stylesheets.empty? || store.stylesheets.first.logo.blank?
    return 'logo.png'
  end

  def pinterest_link_url(url, description)
    url =  url || ''; description = description || ''
    "http://pinterest.com/pin/create/button/?url=#{URI.encode(url)}&description=#{URI.encode(description)}"
  end

  def facebook_link_url(url)
    url =  url || ''
    "https://www.facebook.com/sharer/sharer.php?#{URI.encode(url)}"
  end

  def twitter_link_url(url, text, hashtag)
    url =  url || ''; text = text || ''; hashtag = hashtag || ''
    "https://twitter.com/intent/tweet?hashtags=#{URI.encode(hashtag)}&text=#{URI.encode(text)}&url=#{URI.encode(url)}"
  end

  def tumblr_link_url(url, name, description)
    url =  url || ''; name = name || ''; description = description || ''
    "http://www.tumblr.com/share/link?url=#{URI.encode(url)}&name=#{URI.encode(name)}&description=#{URI.encode(description)}"
  end

  def rich_pin_tags(product)
    tag("meta", property: 'og:title', content: product.name) +
        tag("meta", property: 'og:type', content: 'product') +
        tag("meta", property: 'og:price:amount', content: product.price) +
        tag("meta", property: 'og:price:currency', content: current_currency) +
        tag("meta", property: 'og:url', content: product_url) +
        tag("meta", property: 'og:description', content: product.description)+
        tag("meta", property: 'og:site_name', content: 'Ann Arbor T-Shirt Company')+
        tag("meta", property: 'og:availability', content: 'instock')
  end

  def variant_button_width(text)
    if text.length > 7
      '45%'
    else
      'inherit'
    end
  end

  def breadcrumbs(taxon = nil, product = nil)
    if String === product
      sep = product
      product = nil
    end
    crumbs = [content_tag(:li, link_to(current_store.name , store_home_path))]

    if(taxon || product || current_page?(products_path))

      session['last_crumb'] = taxon ? taxon.permalink : nil
      crumbs = [content_tag(:li, link_to(current_store.name , store_home_path))]

      if taxon
        crumbs << taxon.ancestors.collect { |ancestor| content_tag(:li, link_to(ancestor.name , seo_url(ancestor))) } unless taxon.ancestors.empty?
        if product
          crumbs << content_tag(:li, link_to(taxon.name , seo_url(taxon)))
          crumbs << content_tag(:li, content_tag(:span, product.name), class: 'active')
        else
          crumbs << content_tag(:li, content_tag(:span, taxon.name), class: 'active')
        end
      elsif product
        #crumbs << content_tag(:li, link_to(t('products') , products_path))
        crumbs << content_tag(:li, content_tag(:span, product.name), class: 'active')
      else
        crumbs << content_tag(:li, content_tag(:span, t('products')), class: 'active')
      end
    elsif current_page?('/cart')
      crumbs << content_tag(:li, content_tag(:span, t('shopping cart')), class: 'active')
    end
    content_tag(:ol, raw(crumbs.flatten.map{|li| li.mb_chars}.join), class:'breadcrumb')
  end

  def last_crumb_path
    plink = session['last_crumb']
    if plink && taxon = Spree::Taxon.find_by_permalink(plink)
      seo_url(taxon)
    else
      products_path
    end
  end

  def taxons_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :ul, class: 'taxons-list' do
      root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
        content_tag :li, class: css_class do
          link_to(taxon.name, seo_url(taxon)) +
              taxons_tree(taxon, current_taxon, max_level - 1)
        end
      end.join("\n").html_safe
    end
  end

  def flash_messages(opts = {})
    opts[:ignore_types] = [:commerce_tracking].concat(Array(opts[:ignore_types]) || [])

    flash.each do |msg_type, text|
      unless opts[:ignore_types].include?(msg_type)
        concat(content_tag(:div, content_tag(:div, text, class: "container"), class: "flash #{msg_type}"))
      end
    end
    nil
  end

  def sanitize_id(value)
    value.gsub(/[^a-zA-Z0-9\-_]/, '-')
  end

  def thumbnail_image(product, options = {}, option_value = nil, style = :small)
    # TODO: This is a complete hack to get masonry working
    # Solves the problem addressed https://github.com/passy/angular-masonry/issues/4

    begin
      if option_value
        image = product.images.where(thumbnail: true, option_value_id: option_value.id).first
      else
        image = product.images.where(thumbnail: true).shuffle[0]
      end

      if !image
        image = product.images.first
      end

      # options[:style] = "min-height: #{thumbnail_min_height(image, 176)}px;"

      create_product_image_tag(image, product, options, style)

    rescue
      begin
        link_to( small_image(product, {itemprop: "image"}), url, :itemprop => 'url')
      rescue NameError
      end
    end
  end

  def ipsum
    %(Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
    magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
    reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
    deserunt mollit anim id est laborum.")
  end

end
