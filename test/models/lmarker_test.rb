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
# Indexes
#
#  index_lmarkers_on_user_id  (user_id)
#

require 'test_helper'

class LmarkerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
