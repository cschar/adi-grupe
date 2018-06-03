# == Schema Information
#
# Table name: grupes
#
#  id           :integer          not null, primary key
#  name         :string
#  location_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creator_id   :integer
#  locked_in_at :datetime
#  capacity     :integer          default(2)
#

require 'test_helper'

class GrupeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
