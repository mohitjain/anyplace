module Api
  module V1
    class HotelsController < ApiController

      # param :filters, Hash
      #   param :hotel_name, String
      #   param :room_pricing, Hash
      #     param :min, Integer
      #     param :max, Integer
      #   end
      #   param :coordinates, Hash
      #     param :city_id, String
      #   end
      # end
      # param :available_room_count, Hash
      #   param :checkin, String
      #   param :checkout, String
      #   param :occupancy_limit, Integer
      # end
      # param :format_response, Hash
      #   param :sort_params, Hash
      #     param :sort_on, String
      #     param :ascending, String
      #   end
      #   param :batch, Hash
      #     param :page_number, Integer
      #     param :per_page, Integer
      #   end
      # end

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
