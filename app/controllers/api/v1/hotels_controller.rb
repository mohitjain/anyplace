module Api
  module V1
    class HotelsController < ApiController

      def index
        @hotels = Hotel.page params[:page]
      end

      def show
      end

      def availability

      end

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
