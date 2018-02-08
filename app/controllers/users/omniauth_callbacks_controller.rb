 class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   before_action :set_service
   before_action :set_user

   attr_reader :service, :user  #reference @service just like it was a local variable 'service'

  def facebook
    handle_auth "Facebook"
  end

   def twitter
     handle_auth "Twitter"
   end


   private

   #1. user is signed in and service already exists
   #2. user is signed in and they dont have this service, we add it
   #3. User is logged out and they dont have an account at all
   #4. User is logged out and they have an account that matches their email
   #5 User is logged out, thy log into new account which doesnt match their old one

   def handle_auth(kind)

     service = Service.where(provider: auth.provider, uid: auth.uid).first

     if service.present?
       service.update(service_attrs)
     else
       # user.save
       # You cannot call create unless the parent is saved
       user.services.create(service_attrs)
     end

     #when we are signed in and try to connect an account already connected on another account

     if user_signed_in? and service.user != current_user
       flash[:alert] =  "Cant Connect: That #{kind} account is already connected to a different account here"
       redirect_to edit_user_registration_path

     elsif user_signed_in?
       flash[:notice] =  "Your #{kind} account was connected"
       redirect_to edit_user_registration_path
     else
       sign_in_and_redirect user, event: :authentication
       set_flash_message :notice, :success,kind: kind
     end

   end

   def set_user

     if user_signed_in?  #1,2
       puts "User is signed in"
       puts "using"
       puts current_user
       @user = current_user
     elsif service.present?
       puts "service present in DB but user is not signed in"
       puts "link signing in user to that service"
       puts service
       puts service.user

       # for case when we are logging in w Facebook but already have matching user linked to that service
       @user = service.user

     elsif User.where(email: auth.info.email).any?
       flash[:alert] = "An account with this email already exists, please sign in with that account
         before connecting your #{auth.provider.titleize} account"
       redirect_to new_user_session_path
     else
        @user = create_user
     end
   end


 def set_service
    @service = Service.where(provider: auth.provider, uid: auth.uid).first
  end



 def auth
   request.env['omniauth.auth']
 end

 def create_user
   User.create(
       email: auth.info.email,
       password: Devise.friendly_token[0,20]
   )
 end

 def service_attrs
   #wont blow up when we connect to twitter account (doesnt give an expires at!)
   expires_at = auth.credentials.expires_at? ? Time.at(auth.credentials.expires_at) : nil
    {
        provider: auth.provider,
        uid: auth.uid,
        expires_at:  expires_at,
        access_token: auth.credentials.token
    }
 end



  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end


end



 # You should configure your model like this:
 # devise :omniauthable, omniauth_providers: [:twitter]

 # You should also create an action method in this controller like this:
 # def twitter
 # end

 # More info at:
 # https://github.com/plataformatec/devise#omniauth

 # GET|POST /resource/auth/twitter
 # def passthru
 #   super
 # end



 # GET|POST /users/auth/twitter/callback
 # def failure
 #   super
 # end