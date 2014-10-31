Spree::HomeController.class_eval do
  def index
    session[:store] = nil

    add_current_store_ids_to_params
    @taxonomies = get_taxonomies

    if current_store.homepage_layout == 'default'
      @searcher = build_searcher(params)
      @products = @searcher.retrieve_products
    else

      @media = @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'media')
      @apparel = @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'apparel')
      @accessories = @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'accessories')

    end
  end

end