class AddThumbnailToAsset < ActiveRecord::Migration
  def change
    add_column :spree_assets, :thumbnail, :boolean
    add_index :spree_assets, :thumbnail
  end
end
