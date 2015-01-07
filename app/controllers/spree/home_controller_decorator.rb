Spree::HomeController.class_eval do
  def index
    session[:store] = nil

    add_current_store_id_to_params
    @taxonomies = get_taxonomies

    layout = current_store.try(:homepage_layout)

    if layout.nil? || layout == 'default'
      @searcher = build_searcher(params)
      @products = @searcher.retrieve_products
    else

      @products = {}
      %w(media apparel accessories).each do |category|
        if category == 'media'
          limit = 12
        elsif category == 'apparel'
          limit = 36
        else
          limit = 24
        end

        @products[category] = {
          taxon: @taxonomies.find_by(name: 'collection').taxons.find_by(name: category)
        }
        @products[category][:products] = build_searcher(params.merge(taxon: @products[category][:taxon].id, include_images: true)).retrieve_products
        # .limit(limit)
      end

      # @media = {
      #     taxon: @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'media')
      # }
      # @media[:products] = build_searcher(params.merge(taxon: @media[:taxon].id, include_images: true)).retrieve_products.limit(4)

      @apparel = @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'apparel')
      @accessories = @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'accessories')

    end
  end

end
