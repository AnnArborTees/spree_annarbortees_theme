require 'spec_helper'

describe 'products', caching: true do

  let!(:store) { @default_store }
  let!(:store2) { create(:alternative_store) }
  let!(:product) { create(:product, stores: [store, store2]) }


  describe '#show' do

    before do
      visit spree.product_path(product)
      expect(cache_writes.count).to eq(1)
      clear_cache_events
    end

    it 'reads from cache upon a second viewing' do
      visit spree.product_path(product)
      expect(cache_writes.count).to eq(0)
    end

    it 'only caches for the store visited' do
      visit spree.product_path(product)

      # swap stores
      store.update_attribute(:default, 0)
      store2.update_attribute(:default, 1)
      visit spree.product_path(product)

      expect(cache_writes.count).to eq(1)
    end

  end

end