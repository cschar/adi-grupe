# == Schema Information
#
# Table name: locations
#
#  id              :integer          not null, primary key
#  name            :string
#  latitude        :float
#  longitude       :float
#  ltype           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  total_grupes    :integer          default(0)
#  recent_quest_id :integer
#  region          :text
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
