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
#  hotel_id     :uuid             not null, indexed => [price_date], indexed => [room_type_id]
#  room_type_id :uuid             not null, indexed => [hotel_id], indexed => [price_date]
#  price_date   :date             not null, indexed => [hotel_id], indexed => [room_type_id]
#  price        :float            default(0.0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_pricings_on_hotel_id_and_price_date      (hotel_id,price_date)
#  index_pricings_on_hotel_id_and_room_type_id    (hotel_id,room_type_id)
#  index_pricings_on_room_type_id_and_price_date  (room_type_id,price_date) UNIQUE
#
