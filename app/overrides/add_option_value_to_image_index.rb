Deface::Override.new(
  virtual_path: "spree/admin/images/index",
  name:         "Add option value column to colgroup",
  replace: "colgroup",
  partial: 'spree/admin/images/index_colgroup'
)

Deface::Override.new(
  virtual_path: "spree/admin/images/index",
  name:         "Add option value header to table head",
  replace: "tr[data-hook='images_header']",
  partial: 'spree/admin/images/index_head_tr'
)

Deface::Override.new(
  virtual_path: "spree/admin/images/index",
  name:         "Add option value datum to table body",
  replace: "tr[data-hook='images_row']",
  partial: 'spree/admin/images/index_body_tr'
)
