require 'spec_helper'

feature 'ProductLayout' do
  context 'as a site visitor I visit a product with the default layout ', admin: true, pending: false do

    let(:store) { create(:store) }
    let(:product) { create(:base_product, layout: 'default', stores: [store]) }


    scenario 'it renders the default layout ', js: false, wip: false do
      visit spree.product_path(product)
      expect(page).to have_css('#variantTabs')
    end
  end

  context 'as a site visitor viewing a product', js: true do
    let!(:image_path) { "#{Rails.root}/spec/fixtures/images/" }
    let!(:product) { create(:base_product, layout: 'imprinted_apparel') }

    before(:each) do
      styles = [
        double('style', id: 1, presentation: 'Unisex'),
        double('style', id: 4, presentation: 'Ladies')
      ]

      image_1 = Spree::Image.new(
        attachment: image_path + "bestshirt.png",
        option_value_id: 1
      )
      image_2 = Spree::Image.new(
        attachment: image_path + "bestshirt2.png",
        option_value_id: 4
      )

      product.variant_images = [image_1, image_2]

      allow_any_instance_of(Spree::Product)
        .to receive(:option_values_for_option_type)
        .and_return styles

      visit spree.product_path(product)
    end

    scenario 'when I click on a style option, the image changes to one that represents that style' do
      expect(page).to have_css 'li.active > a[href="#Unisex"]'
      expect(page).to have_css "div.item.active > img[alt='Bestshirt']"

      find('li > a[href="#Ladies"]').click

      expect(page).to have_css "div.item.active > img[alt='Bestshirt2']"
    end
  end

end