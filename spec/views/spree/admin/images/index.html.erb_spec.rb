require 'spec_helper'

describe 'spree/admin/images/index.html.erb', image_spec: true, story_142: true do
  let!(:shirt_style_type) { create :option_type, name: 'shirt-style', presentation: 'shirt style' }
  let!(:unisex_value) { create :option_value, name: 'unisex', presentation: 'Unisex', option_type: shirt_style_type }
  let!(:ladies_value) { create :option_value, name: 'ladies', presentation: 'Ladies', option_type: shirt_style_type }
  let!(:product) { create :custom_product }

  before(:each) do
    image = double('Image', id: 0, alt: 'duhhhhh')
    allow(image).to receive_message_chain(:attachment, :url)
      .and_return 'http://image.com/image.png'

    allow(view).to receive(:render).and_return ''

    product.master.option_values += [unisex_value, ladies_value]
    allow(product).to receive(:variant_images).and_return image

    assign(:product, create(:product))
  end

  context 'when the image has no set option value' do
    it 'should have an option value column' do
      render
      expect(rendered).to have_css 'th', text: 'Option Value'
      expect(rendered).to have_css 'td', text: '<None>'
    end
  end
end