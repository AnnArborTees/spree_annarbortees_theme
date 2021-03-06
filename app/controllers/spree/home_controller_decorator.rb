Spree::HomeController.class_eval do

  def index
    session[:store] = nil

    add_current_store_id_to_params
    if current_store
      @taxonomies = current_store.taxonomies.includes(root: :children)
    else
      @taxonomies = []
    end

    @page = current_store.try(:page)
    layout = current_store.try(:homepage_layout)

    if @page
      render template: 'spree/static_content/show'
    elsif layout.nil? || layout == 'default'
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

      @apparel = @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'apparel')
      @accessories = @taxonomies.find_by(name: 'collection').taxons.find_by(name: 'accessories')

    end
  end

  private

  def determine_layout
    return @page.layout if @page && @page.layout.present? && !@page.render_layout_as_partial?
    Spree::Config.layout
  end
end
