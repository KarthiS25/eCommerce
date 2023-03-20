class Admin::ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_product, only: %i[ show edit update destroy ]

    def index
            @products = Product.all
        end
    
    def show
    end

    def new
        @product = Product.new
    end

    def edit
    end

    def create
        @product = Product.new(product_params)
        # binding.pry

        # file_name = params[:product][:images].original_name.split('.').[0]
        # if params[:product][:images].present?
        #   image = {
        #     io: params[:product][:images],
        #     content_type: 'image/jpg',
        #     filename: file_name,
        #     key:"#{file_name +'-'+Time.zone.now.to_s}"
        #   }
        #   @product.images.attach(image)
        # end
        respond_to do |format|
            if @product.save
                format.html{ redirect_to products_path, notice: "Product was successfully created"}
            else
                format.html{ render :new, status: :unprocessable_entity}
            end
        end
    end

    def update
        respond_to do |format|
            if @product.update(product_params)
              format.html { redirect_to products_path, notice: "Product was successfully updated." }
            else
              format.html { render :edit, status: :unprocessable_entity }
            end
          end
    end

    def destroy
        @product.destroy
    
        respond_to do |format|
          format.html { redirect_to products_path, notice: "Products was successfully destroyed." }
        end
      end

    def delete_image_attachment
        @image = ActiveStorage::Blob.find_signed(params[:id])
        @image.attachments.first.purge
        redirect_back(fallback_location: edit_product_path)
    end

    private

    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:name, :description, :price, :images => [])
    end
end