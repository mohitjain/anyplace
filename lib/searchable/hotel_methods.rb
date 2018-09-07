require "#{Rails.root}/lib/filterable.rb"
module Searchable
  module HotelMethods

    def self.included(base)
      base.public_send :include, Filterable
      base.extend(ClassMethods)
    end

    module ClassMethods

      def searchable_match_attributes
        [
          :id,
          :name,
        ]
      end

      def searchable_joins_attributes
        {
          pricings: {
            db_column_name: :id,
            filter_param_name: :price,
            table_name: :pricings
          },
        }
      end

      def apply_filters(params)
        records = super(params)
        params = params.with_indifferent_access
        filtered_params = params[name.underscore.to_sym] || params[:filters] || params
        return records if filtered_params.blank?
        records
      end

    end
  end
end
