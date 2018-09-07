module Api
  module V1
    class HotelsController < ApiController

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
        @hotels = Hotel.live.page params[:page]
      end

      def show; end

      def availability; end

      private

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
