object false
child @client => :client do
  extends "api/v1/objects/client"
end

child @pricings => :pricings do
  extends "api/v1/objects/pricing"
end
extends("api/v1/shared/pagination", locals: { pagination_object: @pricings })
