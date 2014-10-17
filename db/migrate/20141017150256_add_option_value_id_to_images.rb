class AddOptionValueIdToImages < ActiveRecord::Migration
  def change
    add_column :spree_assets, :option_value_id, :integer
    add_index :spree_assets, :option_value_id
  end
end
