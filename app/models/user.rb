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
#  settings               :text
#  preferences            :json
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

module IdentityCoder
  extend self

  def load(data)
    data || {}
  end

  def dump(data)
    data || {}
  end
end

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

  has_many :gups, dependent: :destroy
  has_many :grupes, through: :gups

  ##### model relations #####
  has_many(:markers)
  has_many(:lmarkers)
  has_many(:firetrees)
  has_many :grupecomments

  # rails g migration CreateJoinTableUsersGrupes users groups
  #has_and_belongs_to_many :grupes

   #### mailboxer
   acts_as_messageable

   #### active record store
   # http://api.rubyonrails.org/classes/ActiveRecord/Store.html
   ## since settings column is text, we have to use store method
   store :settings, accessors: [ :weekly_email, :monthly_newsletter], coder: JSON  #JSON/YML etc.

   ###  preferences is json column, so store_accessor used
   store_accessor :preferences, :start_location

  #  typed_store :settings, coder: JSON do |s|
  #   s.string :weekly_email, default: true
  #   s.string :monthly_newsletter, default: true
  #  end

  #  typed_store :preferences, coder: IdentityCoder do |a|
  #   #a.string :start_location, default: "o"
  #  end

  # manual typed-store esque
  def weekly_email
    ActiveModel::Type::Boolean.new.cast(super.to_s)
  end

  

   def myname_meth
     "User [][][][]]  #{id}"
   end
   def display_name
     " ubo-ola #{id}"
   end

   def mailboxer_email(object)
     nil
   end

   def confirmed_for(grupe)
    self.gups.where('grupe_id = ? AND confirmed_time IS NOT NULL', grupe.id).exists?
   end



 



end
