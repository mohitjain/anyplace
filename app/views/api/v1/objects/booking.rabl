attribute :id, :checkin, :checkout, :monthly_rent, :rent, :status, :number_of_rooms, :created_at, :updated_at

[
  :user,
  :hotel,
  :room_type,
].each do |entity|
  child entity do
    extends "api/v1/objects/#{entity}"
  end
end
