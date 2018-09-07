attributes :id, :name, :address, :description
child :room_types do
  extends "api/v1/objects/room_type", locals: { pricings: locals[:pricings] }
end
