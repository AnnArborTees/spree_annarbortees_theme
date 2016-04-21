Spree::Core::Engine.routes.draw do
  get '/cart_count', :to => 'store#cart_count', :as => :cart_count
  get '/help', :to => 'freshdesk/solutions#index', as: :help
  post '/contact', to: 'freshdesk/solutions#contact'
  get '/toggle_backorder_preference', to: 'checkout#update_backorder_preference', as: :toggle_backorder_preference

  post '/check_user_email', to: 'checkout#check_email', as: :checkout_check_email
  post '/assign_user_to_order', to: 'checkout#assign_user', as: :checkout_assign_user

  resources :stylesheets, only: :show

  namespace :admin do
    resources :stylesheets
  end

end
