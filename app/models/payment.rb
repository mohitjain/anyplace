class Payment < ApplicationRecord
  belongs_to :booking
  has_one :user, through: :booking
  before_validation :set_unique_txnid
  enum status: {
    pending: 0,
    success: 1,
    failed: 2
  }

  enum gateway: {
    stripe: 0
  }

  after_update :mark_booking_as_confirmed

  private

  def set_unique_txnid
    return true if txnid.present?
    self.txnid = SecureRandom.uuid
  end

  def mark_booking_as_confirmed
    return true unless success?
    booking.status = "confirmed"
    booking.save
    true
  end

end

# == Schema Information
#
# Table name: payments
#
#  id         :uuid             not null, primary key
#  booking_id :uuid             not null, indexed
#  gateway    :integer          default("stripe"), not null
#  txnid      :string           not null, indexed
#  amount     :float            default(0.0), not null
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gateway_id :string
#
# Indexes
#
#  index_payments_on_booking_id  (booking_id)
#  index_payments_on_txnid       (txnid)
#
