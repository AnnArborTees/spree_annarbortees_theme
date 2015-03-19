Deface::Override.new(:virtual_path => 'spree/admin/shared/_store_sub_menu',
                     :name => 'stylesheets_link',
                     :insert_bottom => "[data-hook='admin_store_sub_tabs']",
                     text: %q(
<%= tab :stylesheets %>
  ) )