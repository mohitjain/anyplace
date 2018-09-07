attributes :id, :available_rooms, :availability_date
child :room_type do
  extends "api/v1/objects/room_type"
end
