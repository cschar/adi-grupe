# == Schema Information
#
# Table name: grupes
#
#  id          :integer          not null, primary key
#  name        :string
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Grupe < ApplicationRecord

  # rails g migration CreateJoinTableUsersGrupes users groups
  has_and_belongs_to_many :users

  # only 1 location can be linked to a grupe
  belongs_to(:location)

end
