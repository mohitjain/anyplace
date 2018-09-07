class RoomType < ApplicationRecord
  belongs_to :hotel
  has_many :availabilities
  validates :name, presence: true
  validates :occupancy_limit, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    integer: true,
  }

  scope :live, -> { where(active: true) }

  def to_label
    [hotel.name, name].join(" --- ")
  end



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
#
# Indexes
#
#  index_room_types_on_hotel_id  (hotel_id)
#
