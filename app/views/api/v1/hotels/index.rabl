object false
child @client => :client do
  extends "api/v1/objects/client"
end

child @hotels => :hotels do
  extends "api/v1/objects/hotel"
end
extends("api/v1/shared/pagination", locals: { pagination_object: @hotels })
