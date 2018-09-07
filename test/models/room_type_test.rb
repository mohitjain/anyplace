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
#  id         :uuid             not null, primary key
#  category   :integer          default(NULL), not null
#  hotel_id   :uuid             not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_room_types_on_hotel_id  (hotel_id)
#
