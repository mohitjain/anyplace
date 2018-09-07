require "#{Rails.root}/lib/model_filter.rb"
module Filterable

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def searchable_match_attributes
      []
    end

    def searchable_joins_attributes
      {}
    end

    def apply_filters(params, records = nil)
      ::ModelFilter.new(
        model_class: self,
        searchable_match_attributes: searchable_match_attributes,
        searchable_joins_attributes: searchable_joins_attributes,
        params: params,
        records: records
      ).filtered_records
    end

  end
end
