ActiveAdmin.register Hotel do
  permit_params :name, :address, :description, :active

  filter :name
  filter :address
  filter :created_at
  filter :updated_at
  filter :active

  show do
    default_main_content

    panel "Room Types" do
      table_for hotel.room_types do |room_type|
        column :name
        column :occupancy_limit
        column :created_at
      end
    end

    panel "Availabilities" do
      table_for hotel.availabilities do |availability|
        column :hotel_room
        column :number_of_rooms
        column :available_rooms
        column :created_at
        column :updated_at
      end
    end

    panel "Pricings" do
      table_for hotel.availabilities do |availability|
        column :id
        column :room_type
        column :price_date
        column :price
        column :created_at
      end
    end
  end

end
