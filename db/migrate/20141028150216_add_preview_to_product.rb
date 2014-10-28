class AddPreviewToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :digital_preview, :text
  end
end
