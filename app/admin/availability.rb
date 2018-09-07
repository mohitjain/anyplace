ActiveAdmin.register Availability do
  permit_params :hotel_id, :room_type_id, :available_rooms
end
