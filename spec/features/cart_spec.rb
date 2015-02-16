require 'spec_helper'

describe "Cart" do
  it 'shows cart icon on non-cart pages'
  it 'hides cart icon on cart pages'

  it 'prevents double clicking the remove button on cart', js: true, pending: 'Requires implementing sunspot for testing' do
    @product = create(:product, :name => "RoR Mug", stores: [@default_store])
    visit spree.root_path
    click_link "RoR Mug"
    click_button "add-to-cart-button"

    # prevent form submit to verify button is disabled
    page.execute_script("$('#update-cart').submit(function(){return false;})")

    page.should_not have_selector('button#update-button[disabled]')
    page.find(:css, '.delete img').click
    page.should have_selector('button#update-button[disabled]')
  end

  it "does not error out with a 404 when GET'ing to /orders/populate" do
    visit '/orders/populate'
    within(".error") do
      page.should have_content(Spree.t(:populate_get_error))
    end
  end

  it 'allows you to remove an item from the cart', :js => true, pending: 'Requires implementing sunspot for testing'   do
    create(:product, :name => "RoR Mug")
    visit spree.root_path
    click_link "RoR Mug"
    click_button "add-to-cart-button"
    within("#line_items") do
      click_link "delete_line_item_1"
    end
    page.should_not have_content("Line items quantity must be an integer")
    page.should_not have_content("RoR Mug")
    page.should have_content("Your cart is empty")

    within "#link-to-cart" do
      page.should have_content("EMPTY")
    end
  end

  it 'allows you to empty the cart', js: true, pending: 'Requires implementing sunspot for testing'   do
    create(:product, :name => "RoR Mug")
    visit spree.root_path
    click_link "RoR Mug"
    click_button "add-to-cart-button"

    page.should have_content("RoR Mug")
    click_on "Empty Cart"
    page.should have_content("Your cart is empty")

    within "#link-to-cart" do
      page.should have_content("EMPTY")
    end
  end

  context "product contains variants but no option values", js: true, pending: 'Chris this should work' do
    # let(:variant) { create(:variant) }
    let(:product) { create(:product, variants: [create(:variant)], stores: [ @default_store ]) }

    before { product.variants.first.option_values.destroy_all }

    it "still adds product to cart", inaccessible: true do
      visit spree.product_path(product)
      find('.buy-button').click
      visit spree.cart_path
      page.should have_content(product.name)
    end
  end

  it "should have a surrounding element with data-hook='cart_container'" do
    visit spree.cart_path
    page.should have_selector("div[data-hook='cart_container']")
  end
end