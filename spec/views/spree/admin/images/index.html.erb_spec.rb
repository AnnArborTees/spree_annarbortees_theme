require 'spec_helper'

describe 'spree/admin/images/index.html.erb', image_spec: true, story_142: true do
  let!(:shirt_style_type) { create :option_type, name: 'shirt-style', presentation: 'shirt style' }
  let!(:unisex_value) { create :option_value, name: 'unisex', presentation: 'Unisex', option_type: shirt_style_type }
  let!(:ladies_value) { create :option_value, name: 'ladies', presentation: 'Ladies', option_type: shirt_style_type }
  let!(:product) { create :custom_product }
  let!(:image) { Spree::Image.create }

  before(:each) do
    allow(image).to receive_message_chain(:attachment, :url)
      .and_return 'http://image.com/image.png'

    template = { template: 'spree/admin/images/index' }

    allow(view).to receive(:render).and_return ''

    allow(view).to receive(:render)
      .with(hash_including(template), anything)
      .and_call_original    

    allow(view).to receive(:new_admin_product_image_url)
      .and_return 'http://duhhhh.com'
    allow(view).to receive(:edit_admin_product_image_url)
      .and_return 'http://duhhhh.com'
    allow(view).to receive(:admin_product_image_url)
      .and_return 'http://duhhhh.com'
    allow(view).to receive(:update_positions_admin_product_images_url)
      .and_return 'http://ddd.com'

    product.master.option_values += [unisex_value, ladies_value]
    allow(product).to receive(:variant_images).and_return [image]
    allow(product).to receive_message_chain(:images, :any?)
      .and_return true

    assign(:product, product)
  end

  context 'when the image has no set option value' do
    it 'should have an option value column with "none" in its cel' do
      render
      expect(rendered).to have_css 'th', text: 'Option Value'
      expect(rendered).to have_css 'td', text: 'None'
    end
  end

  context 'when the image has a set option value' do
    it 'should render it' do
      allow(image).to receive_message_chain(:option_value, :try)
        .with(:presentation)
        .and_return 'THAT VALUE'
      render
      expect(rendered).to have_css 'td', text: 'THAT VALUE'
    end
  end
end