module Api
  module V1
    class HotelsController < ApiController
      before_action :find_hotel, only: [:show, :availability]

      # {
      #   "filters": {
      #     "hotel_name": ""
      #   },
      #   "room_pricing": {
      #     "min": 10,
      #     "max": 20
      #   },
      #   "available_room_count": {
      #     "checkin": "18/9/2018",
      #     "checkout": "20/9/2018",
      #     "number_of_rooms": 2,
      #   },
      #   "batch": {
      #     "page_number": 1,
      #     "per_page": 1
      #   }
      # }
      def index
        @hotels, @pricings = Hotel.apply_filters params.permit!.to_hash
      end

      def show
        @hotel, @pricings = Hotel.apply_filters params.permit!.to_hash
      end

      private

      def find_hotel
        @hotel = Hotel.where(id: params[:id]).first
        if @hotel.nil?
          @full_messages = ["Hotel not found"]
          render 'api/v1/shared/custom_error', status: :not_found
          return
        end
      end

      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :password,
        )
      end
    end
  end
end
