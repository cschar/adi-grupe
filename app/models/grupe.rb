class Grupe < ApplicationRecord

  # rails g migration CreateJoinTableUsersGrupes users groups
  has_and_belongs_to_many :users

  # only 1 location can be linked to a grupe
  belongs_to(:location)

end
