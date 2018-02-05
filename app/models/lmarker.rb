# == Schema Information
#
# Table name: lmarkers
#
#  id         :integer          not null, primary key
#  lat        :decimal(, )
#  lng        :decimal(, )
#  user_id    :integer
#  ltype      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_new     :boolean          default(TRUE)
#

class Lmarker < ApplicationRecord
  belongs_to(:user)

end
