class CheckoutsController < ApplicationController

    def show
        current_user.set_payment_processor :stripe
        current_user.payment_processor.customer

        @checkout_session = current_user
            .payment_processor
            .checkout(
                mode: 'payment',
                line_items: 'price_1Ml5LcSAbUh3InK3bo5T8XBZ'
            )
    end

    def create
        product = Product.find(params[:id])
        @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
        price_data: {
            currency: 'inr',
            product_data: {
            name: product.name,
            description: product.description,
            },
            unit_amount: product.price*100,
        },
        quantity: 1,
        }],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
        })
        redirect_to @session.url, allow_other_host: true 
    end

    def success
    end
end