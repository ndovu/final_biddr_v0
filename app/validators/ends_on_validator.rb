class EndsOnValidator < ActiveModel::EachValidator
  
  def validate_each(object, attribute, value)
    unless value >= DateTime.now
      object.errors[attribute] << (options[:message] || "ends_on is not in the future")
    end
    object.errors
  end
end