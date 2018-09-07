module Api
  module V1
    class AvailabilitiesController < ApiController
      before_action :find_hotel, only: [:index, :show, :create, :update]
      before_action :find_availability, only: [:show, :update]

      def index
        @availabilities = @hotel.active_availabilities.page(
          params[:page_number]
        ).per(params[:per_page])
      end

      def create
        @availability = Availability.new(permitted_params)
        if @availability.save
          render 'api/v1/availabilities/show'
        else
          @error_object = @availability
          render 'api/v1/shared/errors', status: :bad_request
        end
      end

      def update
        if @availability.update_attributes(permitted_params)
          render 'api/v1/availabilities/show'
        else
          @error_object = @availability
          render 'api/v1/shared/errors', status: :bad_request
        end
      end

      def show

      end

      private

      def permitted_params
        params.require(:availability).permit(
          :room_type_id,
          :available_rooms,
          :availability_date,
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

      def find_availability
        @availability = @hotel.active_availabilities.where(id: params[:id]).first
        if @availability.nil?
          @full_messages = ["Availability not found for this hotel"]
          render 'api/v1/shared/custom_error', status: :not_found
          return
        end
      end
    end
  end
end
