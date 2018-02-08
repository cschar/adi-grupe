# == Schema Information
#
# Table name: quests
#
#  id         :integer          not null, primary key
#  name       :string
#  body       :text
#  qtype      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class QuestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
