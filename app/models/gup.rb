# == Schema Information
#
# Table name: gups
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  grupe_id       :integer
#  confirmed_time :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  is_creator     :boolean          default(FALSE)
#
# Indexes
#
#  index_gups_on_grupe_id  (grupe_id)
#  index_gups_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (grupe_id => grupes.id)
#  fk_rails_...  (user_id => users.id)
#

class Gup < ApplicationRecord
  belongs_to :user  
  belongs_to :grupe
end
