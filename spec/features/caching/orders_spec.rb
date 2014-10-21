require 'spec_helper'

describe 'orders', caching: true do



  describe 'edit' do
    it 'caches the view'
  end

  describe 'updating the cart' do
    it 'busts the cache when a product quantity is changed'
    it 'busts the cache when a cart is created'
    it 'busts the cache when a product is added to the cart'
  end

end