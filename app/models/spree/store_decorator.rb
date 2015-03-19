Spree::Store.class_eval  do

  has_and_belongs_to_many :stylesheets, join_table: :spree_stores_stylesheets

  def self.homepage_layouts
    %w(default starkid_homepage)
  end

end