class Client < ApplicationRecord
  belongs_to :user
  before_create :ensure_authetication_token

  def ensure_authetication_token
    self.auth_token = Devise.friendly_token
  end
end

# == Schema Information
#
# Table name: clients
#
#  id         :uuid             not null, primary key
#  auth_token :string           not null
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
