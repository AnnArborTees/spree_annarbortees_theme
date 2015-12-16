Spree::Core::Engine.routes.draw do
  get '/cart_count', :to => 'store#cart_count', :as => :cart_count
  get '/help', :to => 'freshdesk/solutions#index', as: :help
  post '/contact', to: 'freshdesk/solutions#contact'
  get '/toggle_backorder_preference', to: 'checkout#update_backorder_preference', as: :toggle_backorder_preference

  resources :stylesheets, only: :show

  namespace :admin do
    resources :stylesheets
  end

end
