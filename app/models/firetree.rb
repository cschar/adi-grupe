# == Schema Information
#
# Table name: firetrees
#
#  id         :integer          not null, primary key
#  name       :string
#  body       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Firetree < ApplicationRecord
  belongs_to(:user)
end
