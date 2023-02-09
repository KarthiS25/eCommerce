class Admin::ProductsController < ApplicationController
    before_action :authenticate_user!
    def index
        @products = get_product_data

        respond_to do |format|
            format.html
        end
    end
end