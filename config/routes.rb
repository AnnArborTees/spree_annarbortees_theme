Spree::Core::Engine.routes.draw do
  get '/cart_count', :to => 'store#cart_count', :as => :cart_count
end
