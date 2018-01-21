class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

   devise  :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  # :confirmable, :lockable, :timeoutable,
  :omniauthable, omniauth_providers: [:facebook, :github]# :google_oauth2, :twitter]

  has_many(:markers)
  has_many(:lmarkers)


  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.skip_confirmation!
    end
  end

  def failure
  flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
  redirect_to new_user_registration_url
end

end
