object false
child @client => :client do
  extends "api/v1/objects/client"
end

child @bookings => :bookings do
  extends "api/v1/objects/booking"
end
extends("api/v1/shared/pagination", locals: { pagination_object: @bookings })
