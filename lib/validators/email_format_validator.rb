  class EmailFormatValidator < ActiveModel::EachValidator
    def validate_each(object, attribute, value)
      unless value =~ EMAIL_FORMAT
        object.errors.add(attribute, :email_format, options)
      end
    end
  end
