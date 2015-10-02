class AddHideHomepageText < ActiveRecord::Migration
  def change
    add_column :spree_stylesheets, :hide_banner_text, :boolean, default: false
  end
end
