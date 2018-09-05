require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: clients
#
#  id         :bigint(8)        not null, primary key
#  auth_token :string           not null
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
