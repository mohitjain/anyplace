class Hotel < ApplicationRecord
  validates :name, :address, :description, :active, presence: true

  has_many :pricings
  has_many :availabilities
  has_many :room_types

  scope :live, -> { where(active: true) }
end

# == Schema Information
#
# Table name: hotels
#
#  id          :uuid             not null, primary key
#  name        :string           not null
#  address     :string           not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean          default(TRUE), not null
#
