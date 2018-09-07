  class UnchangeableValidator < ActiveModel::EachValidator
    def validate_each(object, attribute, value)
      if !object.new_record? && value.present?
        original = object.class.where("id = ? ", object.id).select("id, #{attribute.to_s}").first
        if original.send(attribute) != value
          object.errors[attribute] << (options[:message] || "cannot be changed once assigned")
        end
      end
    end
  end
