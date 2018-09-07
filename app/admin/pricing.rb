ActiveAdmin.register Pricing do
  permit_params :hotel_id, :room_type_id, :price_date, :price

  filter :hotel
  filter :price_date
  filter :price
  
end
