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

  validate :check_availability_and_calculate_rent, on: :create

  enum status: {
    pending: 0,
    auto_cancelled: 1,
    confirmed: 2,
  }

  before_validation :set_hotel_id
  after_create :decrease_inventory
  after_update :increase_inventory, if: :auto_cancelled?

  def self.cancel_bookings_with_no_payments
    Booking.pending.where(
      "created_at < ?", Time.now - 15.minutes
    ).each do |booking|
      booking.status = "auto_cancelled"
      booking.save
    end
  end

  private

  def set_hotel_id
    self.hotel_id = room_type.hotel_id if room_type.present?
  end

  def calculate_rent
    number_of_days = (checkout - checkin).to_i
    self.rent = monthly_rent*number_of_days/30
  end

  def check_availability_and_calculate_rent
    hotel_object, pricing = check_availability
    if hotel_object.first.nil?
      self.errors.add(:room_type_id, "is not longer available")
      return false
    else
      self.monthly_rent = pricing[room_type_id]
      calculate_rent
    end
    true
  end

  def check_availability
    data = {
      filters: {
        id: hotel_id,
      },
      available_room_count: {
        checkin: checkin,
        checkout: checkout,
        number_of_rooms: number_of_rooms,
      }
    }
    Hotel.apply_filters(data)
  end

  def decrease_inventory
    self.room_type.availabilities.where(availability_date: (checkin..(checkout-1))).each do |availability|
      availability.decrement!(:available_rooms, number_of_rooms)
    end
  end

  def increase_inventory
    self.room_type.availabilities.where(availability_date: (checkin..(checkout-1))).each do |availability|
      availability.increment!(:available_rooms, number_of_rooms)
    end
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
#  status          :integer          default("pending"), not null, indexed
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
#  index_bookings_on_status                (status)
#  index_bookings_on_user_id               (user_id)
#
