require 'test_helper'

class PricingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: pricings
#
#  id           :uuid             not null, primary key
#  hotel_id     :uuid             not null, indexed => [room_type_id]
#  room_type_id :uuid             not null, indexed => [hotel_id]
#  price_date   :date             not null
#  price        :float            default(0.0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_pricings_on_hotel_id_and_room_type_id  (hotel_id,room_type_id)
#
