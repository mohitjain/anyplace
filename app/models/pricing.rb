require "#{Rails.root}/lib/validators/unchangeable_validator.rb"
class Pricing < ApplicationRecord
  belongs_to :hotel
  belongs_to :room_type

  validates :room_type_id, presence: true
  validates :price, presence: true, numericality: {
    greater_than_or_equal_to: 0,
  }

  validates :price_date, presence: true, unchangeable: true, date: { after_or_equal_to: Proc.new { Date.today }, message: "can't be in past." }

  before_create :set_hotel_id
  scope :active, -> { where("price_date >= ?", Date.today) }

  private

  def set_hotel_id
    self.hotel_id = room_type.hotel_id
  end

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
#  index_pricings_on_room_type_id_and_price_date  (room_type_id,price_date)
#
