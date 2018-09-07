require "#{Rails.root}/lib/validators/unchangeable_validator.rb"
class Availabilty < ApplicationRecord
  belongs_to :hotel
  belongs_to :hotel_room

  validates :hotel_room_id, unchangeable: true, presence: true

  validates :number_of_rooms, :available_rooms, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }
end

# == Schema Information
#
# Table name: availabilties
#
#  id              :uuid             not null, primary key
#  hotel_id        :uuid             not null, indexed => [hotel_room_id], indexed => [hotel_room_id]
#  hotel_room_id   :uuid             not null, indexed => [hotel_id], indexed => [hotel_id]
#  number_of_rooms :integer          default(0), not null
#  available_rooms :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_availabilties_on_hotel_id_and_hotel_room_id  (hotel_id,hotel_room_id)
#  index_availabilties_on_hotel_room_id_and_hotel_id  (hotel_room_id,hotel_id)
#
