ActiveAdmin.register RoomType do
  permit_params :hotel_id, :name, :occupancy_limit, :active
end
