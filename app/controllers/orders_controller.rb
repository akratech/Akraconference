class OrdersController < ApplicationController

  def create
    @order = Order.new({user_id: params["user_id"], price: params["price"]})
    if @order.save
      checkout_paypal(@order)
    else
      render 'new'
    end
  end

  def success_url
    @order = Order.find_by(id: params["format"])
    @order.paypal_payer_id = params["PayerID"] # Paypal return payerid if success. Save it to db
    @order.save
    redirect_to session[:paypal_success_url]
    # Your success code - here & view
  end

  def error_url
    @order = Order.find_by(id: params[:format])
    @s = EXPRESS_GATEWAY.details_for(@order.paypal_token) # To get details of payment
    # @s.params['message'] gives you error
  end
  
  private
    def checkout_paypal(order)
      cut_amount = commision(order.price)
      real_amount = fee_amount(order.price)
      PayPal::SDK.configure(
        :mode      => "sandbox",  # Set "live" for production
        :app_id    => "APP-80W284485P519543T",
        username: "jb-us-seller_api1.paypal.com",
        password: "WX4WTU3S8MY44S7F",
        signature: "AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy")

      @api = PayPal::SDK::AdaptivePayments.new

      # Build request object
      @pay = @api.build_pay({
        :actionType => "PAY",
        :cancelUrl => error_url_orders_url(order),
        :currencyCode => "USD",
        :feesPayer => "SENDER",
        :ipnNotificationUrl => success_url_orders_url(order),
        :receiverList => {
          :receiver => [{
            :amount => cut_amount.round(1),
            :email => "buyer@gopapa.com" },{
            :amount => real_amount.round(1),
            email: "adapt@ive.com"}] },
        :returnUrl => success_url_orders_url(order) })

      # Make API call & get response
      @response = @api.pay(@pay)

      # Access response
      if @response.success?
        puts "[url:] #{success_url_orders_url(order)}"
        @response.payKey
        redirect_to @api.payment_url(@response)  # Url to complete payment
      else
        @response.error[0].message
      end
    end

    def commision(amount)
      (amount * 12.5)/100
    end

    def fee_amount(amount)
      amount - commision(amount)
    end

      # paypal_response = EXPRESS_GATEWAY.setup_purchase(
      #   (order.price * 100).round, # paypal amount is in cents
      #   ip: request.remote_ip,
      #   return_url: success_url_orders_url(order), # return here if payment success
      #   cancel_return_url: error_url_orders_url(order) # return here if payment failed
      # )
      # order.paypal_token = paypal_response.token # save paypal token to db
      # order.save
      # redirect_to EXPRESS_GATEWAY.redirect_url_for(paypal_response.token) and return  # redirect to paypal for payment


end


