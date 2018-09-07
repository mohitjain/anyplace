class ModelFilter

  attr_accessor :model_class, :searchable_match_attributes,
    :searchable_joins_attributes, :filtered_params, :records

  def initialize(model_class:, searchable_match_attributes:, searchable_joins_attributes: {}, params:, records:)
    self.model_class = model_class
    self.searchable_match_attributes = searchable_match_attributes
    self.searchable_joins_attributes = searchable_joins_attributes
    self.filtered_params = (params || {}).with_indifferent_access
    underscore_name = model_class.name.underscore.to_sym
    self.filtered_params = filtered_params[underscore_name] || filtered_params[:filters] || filtered_params
    self.records = records || model_class.public_send(:all)
  end

  def filtered_records
    if filtered_params.present?
      searchable_match_attributes.each do |column_name|
        filter_by_column(column_name)
      end
    end

    apply_association_filters
  end

  def filter_by_column(column_name)
    column_name = column_name.to_sym
    return if filtered_params[column_name].blank?

    self.records = records.where(
      column_name => filtered_params[column_name]
    )
  end

  def apply_association_filters
    searchable_joins_attributes.each do |join_relationship, relationship_details|
      if relationship_details.is_a? Array
        relationship_details.each do |relationship_detail|
          filter_by_association_attribute(join_relationship, relationship_detail)
        end
      else
        filter_by_association_attribute(join_relationship, relationship_details)
      end
    end
    records
  end

  def filter_by_association_attribute(join_relationship, relationship_details)
    db_column_name = relationship_details[:db_column_name]
    filter_param_name = relationship_details[:filter_param_name].to_sym
    table_name = relationship_details[:table_name]

    return if filtered_params[filter_param_name].blank?

    self.records = records.joins(join_relationship.to_sym).where(
      table_name => { db_column_name => filtered_params[filter_param_name]}
    )
  end
end
