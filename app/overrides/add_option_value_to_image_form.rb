Deface::Override.new(
    virtual_path: "spree/admin/images/_form",
    name:         "Add option value select box",
    insert_after: "div[data-hook='variant']",
    text: %q(
    <div>
      <%= f.label 'Option Value' %>
      <%= f.select :option_value_id, ['None'] + @product.option_types.flat_map(&:option_values).map { |v| ["#{v.option_type.presentation}: #{v.presentation}", v.id] }, {}, class: 'select2 fullwidth' %>
    </div>
    <div>
      <%= f.label 'Thumbnail?' %>
      <ul>
          <li><%= f.radio_button :thumbnail, '1' %> <%= Spree.t(:yes) %></li>
          <li><%= f.radio_button :thumbnail, '0' %> <%= Spree.t(:no) %></li>
        </ul>
    </div>
  )
)
