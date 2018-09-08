require "stripe"
module Gateway
  class Stripe
    attr_accessor :booking, :params, :payment

    def initialize(booking, params)
      self.booking = booking
      self.params = params.with_indifferent_access
    end

    def execute
      initiate_the_payment
      save_the_payment
    end

    private

    def initiate_the_payment
      payment = booking.payments.build
      payment.amount = amount
      payment.save
      self.payment = payment
    end

    def save_the_payment
      payment.gateway_id = charge.present? ? charge.id : nil
      payment.status = charge.present? ? "success" : "failed"
      payment.save
    end

    def charge
      return nil if customer.nil?
      return @charge if @charge.present?
      # Should be handled properly.
      # Refer https://stripe.com/docs/api/ruby#error_handling for better exception
      begin
        @charge = ::Stripe::Charge.create(
          amount: amount,
          currency: "usd",
          source: token, # obtained with Stripe.js
          description: "Charge for booking id #{booking.id} for payment id #{payment.id}",
          metadata: {
            booking_id: booking.id,
            payment_id: payment.id,
          }
        )
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        @charge = nil
      end
      @charge
    end

    def customer
      return @customer if @customer.present?
      # Should be handled properly.
      # Refer https://stripe.com/docs/api/ruby#error_handling for better exception
      begin
        if user.stripe_id.present?
          @customer = ::Stripe::Customer.retrieve(user.stripe_id)
        else
          @customer = ::Stripe::Customer.create(
            email: user.email,
            source: token,
          )
          user.stripe_id = @customer.id
          user.save
        end
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        @customer = nil
      end
      @customer
    end

    def token
      params[:token]
    end

    def user
      @user ||= booking.user
    end

    def amount
      @amount ||= (booking.rent * 100).to_i
    end

  end
end
