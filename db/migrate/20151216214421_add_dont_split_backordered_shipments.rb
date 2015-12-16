class AddDontSplitBackorderedShipments < ActiveRecord::Migration
  def change
    add_column :spree_orders, :dont_split_packages_on_backorder, :boolean, default: false, index: true
  end
end
