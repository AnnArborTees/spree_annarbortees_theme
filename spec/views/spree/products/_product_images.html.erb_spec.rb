require 'spec_helper'

describe 'spree/products/_product_images.html.erb', image_spec: true, story_142: true do
  let!(:image_path) { "#{Rails.root}/spec/fixtures/images/" }

  let!(:product) { create :product }

  before(:each) do
    images = [
      double('Image', id: 0, alt: 'dur'),
      double('Image', id: 1, alt: 'dur')
    ]
    allow(images.first).to receive_message_chain(:attachment, :url)
      .and_return image_path + "bestshirt.png"
    allow(images.last).to receive_message_chain(:attachment, :url)
      .and_return image_path + "bestshirt2.png"

    allow(product).to receive(:variant_images).and_return images

    assign(:product, product)
  end

  it 'assigns each image div data-index of the index of the image' do
    render
    expect(rendered).to have_css 'div.item[data-index="0"]'
    expect(rendered).to have_css 'div.item[data-index="1"]'
  end
end