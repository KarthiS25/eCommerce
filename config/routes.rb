Rails.application.routes.draw do
  devise_for :users

  get 'checkout', to: 'checkouts#show'
  post 'checkout/create', to: 'checkouts#create'
  get 'checkout/success', to: 'checkouts#success'
  get 'billing', to: 'billing#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'products#index'
  # Defines the root path route ("/")
  authenticated :user, ->(user) { user.is_admin? } do
    root to: "admin/products#index", as: :admin_root
  end

  authenticated :user, ->(user) { user.is_user? } do
    root to: "products#index", as: :user_root
  end

  scope module: 'admin', path: 'admin' do
    # get 'products' => 'products#index'
    # patch "products/update" => "products#update", as: :admin_products_update
    resources :products
  end
  # resources :products
end
