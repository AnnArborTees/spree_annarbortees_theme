require 'spec_helper'

describe 'spree/admin/images/_form.html.erb', image_spec: true, story_142: true do
  let!(:apparel_style) { create :option_type, name: 'apparel-style', presentation: 'apparel style' }
  let!(:unisex_value) { create :option_value, name: 'unisex', presentation: 'Unisex', option_type: apparel_style }
  let!(:ladies_value) { create :option_value, name: 'ladies', presentation: 'Ladies', option_type: apparel_style }
  let!(:product) { create :custom_product }
  let!(:image_path) { "#{Rails.root}/spec/fixtures/images/" }
  let!(:image) do
    Spree::Image.new
  end

  before(:each) do
    assign(:product, product)
  end

  it 'displays a select field for option value' do
    assign(:variants, [])
    f = nil
    form_for(image, url: spree.admin_product_images_path(product)) { |builder| f = builder }
    
    render partial: 'spree/admin/images/form', locals: { f: f }
    expect(rendered).to have_css 'select.select2.fullwidth[name="image[option_value_id]"]'
  end
end