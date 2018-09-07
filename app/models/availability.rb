require "#{Rails.root}/lib/validators/unchangeable_validator.rb"
class Availability < ApplicationRecord
  belongs_to :hotel
  belongs_to :room_type

  validates :room_type_id, unchangeable: true, presence: true

  validates :available_rooms, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }

  before_create :set_hotel_id

  private

  def set_hotel_id
    self.hotel_id = room_type.hotel_id
  end

end


# == Schema Information
#
# Table name: availabilities
#
#  id                :uuid             not null, primary key
#  hotel_id          :uuid             not null, indexed => [availability_date], indexed => [room_type_id], indexed => [room_type_id]
#  room_type_id      :uuid             not null, indexed => [hotel_id], indexed => [availability_date], indexed => [hotel_id]
#  available_rooms   :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  availability_date :date             not null, indexed => [hotel_id], indexed => [room_type_id]
#
# Indexes
#
#  index_availabilities_on_hotel_id_and_availability_date      (hotel_id,availability_date)
#  index_availabilities_on_hotel_id_and_room_type_id           (hotel_id,room_type_id)
#  index_availabilities_on_room_type_id_and_availability_date  (room_type_id,availability_date)
#  index_availabilities_on_room_type_id_and_hotel_id           (room_type_id,hotel_id)
#
