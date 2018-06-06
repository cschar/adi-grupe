# == Schema Information
#
# Table name: grupes
#
#  id           :integer          not null, primary key
#  name         :string
#  location_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  creator_id   :integer
#  locked_in_at :datetime
#  capacity     :integer          default(2)
#

class Grupe < ApplicationRecord
  
  def locked_count
    2
  end
  
  #rails g model qglink subject:string quest:references grupe:references
  has_many :qglinks, dependent: :destroy
  has_many :quests, through: :qglinks
  has_many :grupecomments, dependent: :destroy

  has_many :gups, dependent: :destroy
  has_many :users, through: :gups

  #scope active_yesterday -> { where('updated_at BETWEEN ? AND ?', 1.day.ago.beginning_of_day, 1.day.ago.end_of_day) }

  # rails g migration CreateJoinTableUsersGrupes users groups
  # has_and_belongs_to_many :users

  # only 1 location can be linked to a grupe
  belongs_to(:location)

  def time_to_live
    5.hours
  end

  def self.clean_up_expired_grupes
    expiry_time = DateTime.now - 5.hours
    Grupe.where('locked_in_at < ?', expiry_time).destroy_all
  end


end
