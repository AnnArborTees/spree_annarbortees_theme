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

  context 'as a site visitor viewing a product', js: true, story_142: true, pending: 'Nigel this should work' do
    let!(:store) { @default_store }
    let!(:image_path) { "#{Rails.root}/../fixtures/images/" }
    let!(:product) { create(:product) }

    before(:each) do
      store.products << product

      option_types = %w(apparel-style apparel-size).map do |name|
        Spree::OptionType.new(name: name, presentation: name)
      end
      product.option_types = option_types

      product.master.option_values = [
        Spree::OptionValue.create(
          option_type: option_types[0],
          name: 'cool-style',
          presentation: 'Cool Style'
        ),

        Spree::OptionValue.create(
          option_type: option_types[1],
          name: 'small',
          presentation: 'S'
        )
      ]

      product.layout = 'imprinted_apparel'
      product.save

      styles = [
        double('style', id: 1, presentation: 'Unisex'),
        double('style', id: 4, presentation: 'Ladies')
      ]

      image_1 = Spree::Image.new(
        attachment: Rack::Test::UploadedFile.new(image_path+"bestshirt.png", 'image/png'),
        option_value_id: 1
      )
      image_2 = Spree::Image.new(
        attachment: Rack::Test::UploadedFile.new(image_path+"bestshirt2.png", 'image/png'),
        option_value_id: 4
      )

      product.master.images = [image_1, image_2]

      allow_any_instance_of(Spree::Product)
        .to receive(:option_values_for_option_type)
        .and_return styles

      visit spree.product_path(product)
    end

    scenario 'when I click on a style option, the image changes to one that represents that style' do
      expect(page).to have_css 'li.active > a[href="#Unisex"]'
      expect(page).to have_css "div.item.active > img[alt='Bestshirt']"

      sleep 0.5
      find('li > a[href="#Ladies"]').click
      sleep 0.5

      expect(page).to have_css "div.item.active > img[alt='Bestshirt2']"
    end
  end

end