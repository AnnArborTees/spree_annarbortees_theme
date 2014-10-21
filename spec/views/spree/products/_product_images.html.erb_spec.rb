require 'spec_helper'

describe 'spree/products/_product_images.html.erb', image_spec: true, story_142: true do
  let!(:image_path) { "#{Rails.root}/spec/fixtures/images/" }

  let!(:product) { create :product }

  before(:each) do
    images = [
      double('Image', id: 0, alt: 'dur', option_value_id: 5),
      double('Image', id: 1, alt: 'dur', option_value_id: 7)
    ]
    allow(images.first).to receive_message_chain(:attachment, :url)
      .and_return image_path + "bestshirt.png"
    allow(images.last).to receive_message_chain(:attachment, :url)
      .and_return image_path + "bestshirt2.png"

    allow(product).to receive(:images).and_return images

    assign(:product, product)
  end

  it 'assigns each image div data-index of the index of the image' do
    render
    expect(rendered).to have_css 'div.item[data-index="0"]'
    expect(rendered).to have_css 'div.item[data-index="1"]'
  end

  it 'assigns each image div data-option-value-id of the option_value id of the image' do
    render
    expect(rendered).to have_css 'div.item[data-option-value-id="5"]'
    expect(rendered).to have_css 'div.item[data-option-value-id="7"]'
  end
end