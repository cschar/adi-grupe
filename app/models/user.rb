# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  points                 :integer          default(0)
#  provider               :string(50)       default(""), not null
#  uid                    :string(500)      default(""), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

   devise  :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  # :confirmable, :lockable, :timeoutable,
  :omniauthable,  omniauth_providers: [:facebook, :github, :twitter]# :google_oauth2, :twitter]

   #omniauth related
   has_many :services , dependent: :destroy

   #### mailboxer
   acts_as_messageable

   def myname_meth
     "User [][][][]]  #{id}"
   end
   def mailboxer_email(object)
     nil
   end



   ##### model relations #####
  has_many(:markers)
  has_many(:lmarkers)
  has_many(:firetrees)

  # rails g migration CreateJoinTableUsersGrupes users groups
  has_and_belongs_to_many :grupes



end
