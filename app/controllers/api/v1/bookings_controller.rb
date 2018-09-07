module Api
  module V1
    class BookingsController < ApiController
      before_action :find_hotel, only: [:show]
      before_action :find_pricing, only: [:show, :update]

      def index
        @bookings = @user.bookings.page(
          params[:page_number]
        ).per(params[:per_page])
      end

      def create
        @booking = Booking.new(permitted_params)
        @booking.user_id = @user.id
        if @booking.save
          render 'api/v1/bookings/show'
        else
          @error_object = @booking
          render 'api/v1/shared/errors', status: :bad_request
        end
      end

      def show

      end

      private

      def permitted_params
        params.require(:booking).permit(
          :checkin,
          :checkout,
          :room_type_id,
          :number_of_rooms,
        )
      end

    end
  end
end
