class ApplicationController < ActionController::API
  include Knock::Authenticable

  def serialize!(resource, options = {}, klass_name = "")
    # Check the class name
    # If not an activerecord relation go ahead
    if resource.class.name != "ActiveRecord::Relation"
      klass = "#{resource.class.name}Serializer"
      # When AR relation is detected try to get
    else
      klass = "#{klass_name}Serializer"
    end

    serializer = klass.constantize
    return serializer.new(resource, options).serialized_json
  end
end
