require 'spec_helper'

feature 'Selects option value by default', story_438: true do

  let!(:store) {create :store, domains: '127.0.0.1', default: true}

  let!(:product_with_multiple_options) {create :product, stores: [store]}
  let!(:product_with_one_option) {create :product, stores: [store]}
  let!(:product_with_no_variants) {create :product, stores: [store]}

  let!(:variant1) {create :variant, product: product_with_one_option, option_values: [option_value1]}
  let!(:variant2) {create :variant, product: product_with_multiple_options, option_values: [option_value1, option_value2]}
  let!(:variant3) {create :variant, product: product_with_multiple_options, option_values: [option_value3, option_value4]}
  let!(:option_type1) {create :option_type, products: [product_with_multiple_options, product_with_one_option]}
  let!(:option_type2) {create :option_type, products: [product_with_multiple_options]}
  let!(:option_value1) {create :option_value, option_type: option_type1}
  let!(:option_value2) {create :option_value, option_type: option_type2}
  let!(:option_value3) {create :option_value, option_type: option_type1}
  let!(:option_value4) {create :option_value, option_type: option_type2}

  scenario 'should select an option value by default', js:true do
    allow_any_instance_of(Spree::ProductsController).to receive(:can_show_product).and_return true

    visit spree.product_path(product_with_multiple_options)
    expect(page).to have_css "input.active[id='#{variant2.id}']"

    visit spree.product_path(product_with_one_option)
    expect(page).to have_css "input.active[id='#{variant1.id}']"
  end

  scenario 'I can add a product without variants to the cart', js: true do
    visit spree.product_path(product_with_no_variants)
    first("input[name=commit]").click
    expect(page).to have_css "h4", text: product_with_no_variants.name
  end

  context 'if by chance an option gets unselected', story_437: true do
    scenario 'it informs me that I must select something, rather than erroring out', js: true do
      visit spree.product_path(product_with_multiple_options)
      execute_script %<$('.variants input').removeClass('active');>
      sleep 2
      first("input[name=commit]").click
      page.driver.browser.switch_to.alert.accept
    end
  end
end
