attributes :id, :name, :occupancy_limit, :active, :number_of_rooms

if locals[:pricings].present? && locals[:pricings]
  node(:price) { |object| "$#{locals[:pricings][object.id]}" }
end
