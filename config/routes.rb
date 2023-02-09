Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  scope module: 'admin', path: 'admin' do
    get 'products' => 'products#index'
  end
end
