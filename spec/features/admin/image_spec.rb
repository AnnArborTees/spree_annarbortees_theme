require 'spec_helper'

feature 'Admin::Product::Image' do
  stub_authorization!

  context 'as an admin with valid credentials, I can ', admin: true, pending: false  do
    scenario 'set an image as a thumbnail'
    scenario 'assign an option value to a thumbnail'
  end

end