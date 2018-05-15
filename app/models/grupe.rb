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
  #rails g model qglink subject:string quest:references grupe:references
  has_many :qglinks, dependent: :destroy
  has_many :quests, through: :qglinks
  has_many :grupecomments, dependent: :destroy

  has_many :gups, dependent: :destroy
  has_many :users, through: :gups

  # rails g migration CreateJoinTableUsersGrupes users groups
  # has_and_belongs_to_many :users

  # only 1 location can be linked to a grupe
  belongs_to(:location)

  def removeNoUserGrupes()
    grupes = findn(0)
    grupes.each do |g|
      g.delete
    end
  end

  def findn(n)
    finds = []
    Grupe.all.each do |g|
      if g.users.all.count == n
        finds = finds + [g]
      end
    end
    finds
  end

  def findni(n)
    finds = []
    Grupe.includes(:users).all.each do |g|
      if g.users.all.count == n
        finds = finds + [g]
      end
    end
    finds
  end


end
