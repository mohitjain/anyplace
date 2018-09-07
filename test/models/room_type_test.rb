require 'test_helper'

class RoomTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: room_types
#
#  id              :uuid             not null, primary key
#  hotel_id        :uuid             not null, indexed
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string           not null
#  occupancy_limit :integer          default(1), not null
#  active          :boolean          default(TRUE), not null
#  number_of_rooms :integer          default(0), not null
#
# Indexes
#
#  index_room_types_on_hotel_id  (hotel_id)
#
