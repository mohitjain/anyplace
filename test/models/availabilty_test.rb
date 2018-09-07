require 'test_helper'

class AvailabiltyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
