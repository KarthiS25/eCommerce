Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user, ->(user) { user.is_admin? } do
    root to: "admin/products#index", as: :admin_root
  end

  authenticated :user, ->(user) { user.is_user? } do
    root to: "products#index", as: :user_root
  end

  scope module: 'admin', path: 'admin' do
    resources :products
    get 'products' => 'products#index'
  end
  resources :products
end
