# == Schema Information
#
# Table name: quests
#
#  id         :integer          not null, primary key
#  name       :string
#  body       :text
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quest < ApplicationRecord
  has_many :qglinks
  has_many :grupes, through: :qglinks
end
