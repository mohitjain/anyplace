ActiveAdmin.register Availability do
  permit_params :hotel_id, :room_type_id, :number_of_rooms, :available_rooms
end
