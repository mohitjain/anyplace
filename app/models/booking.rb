class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :hotel
  belongs_to :room_type

  validates :user_id, :hotel_id, :status, :room_type_id, presence: true

  validates :rent, :monthly_rent,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
    }

  validates :number_of_rooms,
    presence: true,
    numericality: {
      integer: true,
      greater_than: 0,
    }

  validates :checkin, :checkout, presence: true, date: true

  validates :checkin, :checkout, date: {
    after_or_equal_to: Proc.new { Date.today },
    message: "can't be in past."
  }, on: :create

  enum status: {
    pending: 0,
    confirmed: 1,
  }

  before_validation :set_hotel_id

  private

  def set_hotel_id
    self.hotel_id = room_type.hotel_id if room_type.present?
  end



end

# == Schema Information
#
# Table name: bookings
#
#  id              :uuid             not null, primary key
#  user_id         :uuid             not null, indexed
#  hotel_id        :uuid             not null, indexed
#  checkin         :date             not null, indexed => [checkout]
#  checkout        :date             not null, indexed => [checkin], indexed
#  monthly_rent    :float            default(0.0), not null
#  rent            :float            default(0.0), not null
#  status          :integer          default(0), not null
#  room_type_id    :uuid             not null
#  number_of_rooms :integer          default(1), not null
#  meta_data       :json             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_bookings_on_checkin_and_checkout  (checkin,checkout)
#  index_bookings_on_checkout              (checkout)
#  index_bookings_on_hotel_id              (hotel_id)
#  index_bookings_on_user_id               (user_id)
#
