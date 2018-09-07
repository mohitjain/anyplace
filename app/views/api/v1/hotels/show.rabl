object false
child @client => :client do
  extends "api/v1/objects/client"
end

child @hotel => :hotel do
  extends "api/v1/objects/hotel", locals: { pricings: @pricings }
end
