class AddBackorderDetailsToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :backorder_details, :text
  end
end
