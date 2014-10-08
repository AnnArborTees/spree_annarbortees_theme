require 'spec_helper'

describe 'products', :caching => true do
  let!(:store) { create(:default_store) }
  let!(:store2) { create(:alternative_store) }
  let!(:product) { create(:product, stores: [store]) }
  let!(:product2) { create(:product, stores: [store, store2]) }


  describe '#show' do

    before do
      product.update_column(:updated_at, 1.day.ago)
      visit spree.product_path(product)
      expect(cache_writes.count).to eq(1)
      clear_cache_events
    end

    it 'reads from cache upon a second viewing' do
      visit spree.product_path(product)
      expect(cache_writes.count).to eq(0)
    end

    it 'busts the cache for all stores when a product is updated' do
      product2.touch
      visit spree.product_path(product2)

      # swap stores
      store.update_attribute(:default, 0)
      store2.update_attribute(:default, 1)
      visit spree.product_path(product2)

      expect(cache_writes.count).to eq(2)
    end
  end

end