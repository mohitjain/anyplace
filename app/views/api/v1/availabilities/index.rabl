object false
child @client => :client do
  extends "api/v1/objects/client"
end

child @availabilities => :availabilities do
  extends "api/v1/objects/availability"
end
extends("api/v1/shared/pagination", locals: { pagination_object: @availabilities })
