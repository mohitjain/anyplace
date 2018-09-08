module Searchable
  module HotelMethods

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def apply_filters(params, records = nil)
        pricing = []

        params = params.with_indifferent_access
        filters_params = params[:filters] || params || {}
        room_pricing_params = params[:room_pricing] || {}
        available_room_count_params = params[:available_room_count] || {}
        batch_params = params[:batch] || {}
        records = records || Hotel.live

        if filters_params[:hotel_name].present?
          records = records.where("hotels.name LIKE (?)", "#{filters_params[:hotel_name]}%")
        end

        if filters_params[:id].present?
          records = records.where(id: filters_params[:id])
        end

        if room_pricing_params.present?
          if room_pricing_params[:min].present?
            hotel_ids = Pricing.active.group("hotel_id, room_type_id").having("MIN(price) >= #{room_pricing_params[:min]}").pluck(:hotel_id)
            records = records.where("hotels.id IN (?)", hotel_ids)
          end

          if room_pricing_params[:max].present?
            hotel_ids = Pricing.active.group("hotel_id").having("MIN(price) <= #{room_pricing_params[:max]}").pluck(:hotel_id)
            records = records.where("hotels.id IN (?)", hotel_ids)
          end
        end

        records = records.includes(:room_types)
        if available_room_count_params.present?
          if available_room_count_params[:checkin].present? && available_room_count_params[:checkout].present?
            date_range = (available_room_count_params[:checkin].to_date..(available_room_count_params[:checkout].to_date - 1)).to_a
            number_of_rooms = (available_room_count_params[:number_of_rooms] || 1).to_i
            availabilities = Availability.where("availability_date IN (?)", date_range)
            availabilities = availabilities.where("availabilities.room_type_id = ?", available_room_count_params[:room_type_id]) if available_room_count_params[:room_type_id].present?
            hotel_ids = availabilities.group("hotel_id").having("MIN(available_rooms) >= #{number_of_rooms}").pluck(:hotel_id)
            records = records.where("hotels.id IN (?)", hotel_ids)

            pricings = records.joins(:pricings).where(
              "pricings.price_date IN (?)", date_range
            )
            pricings = pricings.where("pricings.room_type_id = ?", available_room_count_params[:room_type_id]) if available_room_count_params[:room_type_id].present?
            pricings = pricings.group("hotel_id, room_type_id").select(
              "pricings.room_type_id as room_type_id, (SUM(price)*30/#{date_range.count}) as final_price"
            ).inject({}){|h, e| h[e.room_type_id] = e.final_price; h}
          end
        end



        page_number = batch_params[:page_number] || 1
        per_page = batch_params[:per_page] || 3
        records = records.page(page_number).per(per_page)
        [records, pricings]
      end

    end
  end
end
