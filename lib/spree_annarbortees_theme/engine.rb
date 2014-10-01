module SpreeAnnarborteesTheme
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_annarbortees_theme'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( spree/frontend/spree_annarbortees_theme.css )
      Rails.application.config.assets.precompile += %w( spree/backend/spree_annarbortees_theme.css )
      Rails.application.config.assets.precompile += %w( spree/backend/spree_annarbortees_theme.js )
      Rails.application.config.assets.precompile += %w( spree/frontend/spree_annarbortees_theme.js )
      Rails.application.config.assets.precompile << %r(noimage\.(?:png|gif|jpg)$)
      Rails.application.config.assets.precompile << %w( logo.png logo.svg michigan-golf-course.png )
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
