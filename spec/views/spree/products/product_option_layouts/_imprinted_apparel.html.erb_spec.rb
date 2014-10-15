require 'spec_helper'

describe 'spree/products/product_option_layouts/_imprinted_apparel.html.erb', image_spec: true, story_142: true do
  let!(:product) { create :product }

  before(:each) do
    styles = [
      double('style', id: 1, presentation: 'Unisex'),
      double('style', id: 4, presentation: 'Ladies')
    ]
    assign(:styles, styles)
    assign(:product, product)
  end

  it 'adds a data-option-value-id to each style tab' do
    render
    expect(page).to have_css 'a[href="#Unisex"][data-option-value-id="1"]'
    expect(page).to have_css 'a[href="#Ladies"][data-option-value-id="2"]'
  end
end