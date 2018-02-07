# == Schema Information
#
# Table name: qglinks
#
#  id         :integer          not null, primary key
#  subject    :string
#  quest_id   :integer
#  grupe_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_qglinks_on_grupe_id  (grupe_id)
#  index_qglinks_on_quest_id  (quest_id)
#
# Foreign Keys
#
#  fk_rails_...  (grupe_id => grupes.id)
#  fk_rails_...  (quest_id => quests.id)
#

class Qglink < ApplicationRecord
  belongs_to :quest
  belongs_to :grupe
end
