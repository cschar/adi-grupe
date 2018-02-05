# == Schema Information
#
# Table name: transactions
#
#  id         :integer          not null, primary key
#  street     :string
#  city       :string
#  zip        :string
#  state      :string
#  beds       :string
#  baths      :string
#  sq__ft     :string
#  sale_date  :datetime
#  price      :integer
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
