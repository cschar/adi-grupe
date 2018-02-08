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

class Quest < ApplicationRecord
  has_many :qglinks, dependent: :destroy
  #https://stackoverflow.com/questions/331394/can-i-set-up-cascade-deleting-in-rails#comment40730432_331626
  # Make sure you understand the difference between using :delete_all and :destroy for
  # this. Both will cause child memberships (1 level for delete [citation needed]
  # and n for destroy (if their children have dependent destroys)) to be removed
  # from the database, but :destroy will instantiate each child object and run any
  # callbacks first, whereas :delete_all will directly run a SQL DELETE statement
  # in the database. :destroy is slower because of that, but it allows you to have
  # callbacks when a record is destroyed. Circumventing Rails on one end and
  # potential n^x instantiation on the other


  has_many :grupes, through: :qglinks


  def times_done_today
    return [*1..100].sample.to_s
  end

  def quest_display_method
    "#{id} - #{name}"
  end
end
