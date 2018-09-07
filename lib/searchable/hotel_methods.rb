module Searchable
  module HotelMethods

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def apply_filters(params, records = nil)
        params = params.with_indifferent_access
        filters_params = params[:filters] || {}
        room_pricing_params = params[:room_pricing] || {}
        available_room_count_params = params[:available_room_count] || {}
        batch_params = params[:batch] || {}
        records = records || Hotel.live

        if filters_params[:hotel_name].present?
          records = records.where("hotels.name LIKE (?)", "#{filters_params[:hotel_name]}%")
        end

        if room_pricing_params.present?
          if room_pricing_params[:min].present?
            hotel_ids = Pricing.active.group("hotel_id").having("MIN(price) >= #{room_pricing_params[:min]}").pluck(:hotel_id)
            records = records.where("hotels.id IN (?)", hotel_ids)
          end

          if room_pricing_params[:max].present?
            hotel_ids = Pricing.active.group("hotel_id").having("MIN(price) <= #{room_pricing_params[:max]}").pluck(:hotel_id)
            records = records.where("hotels.id IN (?)", hotel_ids)
          end
        end

        if available_room_count_params.present?
          if available_room_count_params[:checkin].present? && available_room_count_params[:checkout].present?
            date_range = (available_room_count_params[:checkin].to_date..available_room_count_params[:checkout].to_date).to_a
            number_of_rooms = (available_room_count_params[:available_room_count_params] || 1).to_i
            hotel_ids = Availability.where("availability_date IN (?)", date_range).group("hotel_id").having("MIN(available_rooms) >= #{number_of_rooms}").pluck(:hotel_id)
            records = records.where("hotels.id IN (?)", hotel_ids)
          end
        end

        page_number = batch_params[:page_number] || 1
        per_page = batch_params[:per_page] || 3
        records = records.page(page_number).per(per_page)
        records
      end

    end
  end
end
