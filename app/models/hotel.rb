class Hotel < ApplicationRecord
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
#
