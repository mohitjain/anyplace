attributes :id, :name, :address, :description, :created_at, :updated_at
child :room_types do
  extends "api/v1/objects/room_type", locals: { pricings: locals[:pricings] }
end
