Deface::Override.new(
  virtual_path: "spree/admin/images/_form",
  name:         "Add option value select box",
  insert_after: "div[data-hook='variant']",
  text: %q(
    <div>
      <%= f.label 'Option Value' %>
      <%= f.select :option_value_id, ['None'] + @product.option_types.flat_map(&:option_values).map { |v| ["#{v.option_type.presentation}: #{v.presentation}", v.id] }, {}, class: 'select2 fullwidth' %>
    </div>
  )
)
