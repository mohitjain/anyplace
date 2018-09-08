require "#{Rails.root}/lib/gateway/stripe.rb"
module Api
  module V1
    class PaymentsController < ApiController
      before_action :find_booking, only: [:create]

      def create
        gateway = Gateway::Stripe.new(@booking, permitted_params.to_hash).execute
        gateway.execute
        @payment = gateway.payment
        render 'api/v1/payments/show'
      end

      private

      def permitted_params
        params.require(:payment).permit(
          :token,
        )
      end

      def find_booking
        @booking = @user.bookings.where(id: params[:booking_id]).first
        if @booking.nil?
          @full_messages = ["Booking not found."]
          render 'api/v1/shared/custom_error', status: :not_found
          return
        end
      end

    end
  end
end
