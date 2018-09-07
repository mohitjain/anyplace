module Api
  module V1
    class PricingsController < ApiController
      before_action :find_hotel, only: [:index, :show, :create, :update]
      before_action :find_pricing, only: [:show, :update]

      def index
        @pricings = @hotel.active_pricings.page(
          params[:page_number]
        ).per(params[:per_page])
      end

      def create
        @pricing = Pricing.new(permitted_params)
        if @pricing.save
          render 'api/v1/pricings/show'
        else
          @error_object = @pricing
          render 'api/v1/shared/errors', status: :bad_request
        end
      end

      def update
        if @pricing.update_attributes(permitted_params)
          render 'api/v1/pricings/show'
        else
          @error_object = @pricing
          render 'api/v1/shared/errors', status: :bad_request
        end
      end

      def show

      end

      private

      def permitted_params
        params.require(:pricing).permit(
          :room_type_id,
          :price,
          :price_date,
        )
      end

      def find_hotel
        @hotel = Hotel.where(id: params[:hotel_id]).first
        if @hotel.nil?
          @full_messages = ["Hotel not found"]
          render 'api/v1/shared/custom_error', status: :not_found
          return
        end
      end

      def find_pricing
        @pricing = @hotel.active_pricings.where(id: params[:id]).first
        if @pricing.nil?
          @full_messages = ["Pricing not found for this hotel"]
          render 'api/v1/shared/custom_error', status: :not_found
          return
        end
      end
    end
  end
end
