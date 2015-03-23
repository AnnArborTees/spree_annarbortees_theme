module Spree
  module StylesheetsHelper

    def stylesheet_cache_key(stylesheet)
      "/#{stylesheet.id}/#{stylesheet.updated_at}"
    end

  end
end