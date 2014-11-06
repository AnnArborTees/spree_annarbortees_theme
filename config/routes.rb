Spree::Core::Engine.routes.draw do
  get '/cart_count', :to => 'store#cart_count', :as => :cart_count
  get '/help', :to => 'freshdesk/solutions#index', as: :help
end
