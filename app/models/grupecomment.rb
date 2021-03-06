# == Schema Information
#
# Table name: grupecomments
#
#  id              :integer          not null, primary key
#  grupe_id        :integer
#  user_id         :integer
#  comment         :string
#  grupecomment_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_grupecomments_on_grupe_id  (grupe_id)
#  index_grupecomments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (grupe_id => grupes.id)
#  fk_rails_...  (user_id => users.id)
#

class Grupecomment < ApplicationRecord
  belongs_to :grupe
  belongs_to :user
  has_one :grupecomment, through: :parent
end
