# == Schema Information
#
# Table name: markers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  lat        :decimal(10, 6)
#  lng        :decimal(10, 6)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Marker < ApplicationRecord
  belongs_to(:user)

end
