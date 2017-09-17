class Mutations::SignInUser < GraphQL::Function
  argument :input, !Types::AuthProviderEmailInput

  type Types::AuthenticateType

  def call(obj, args, ctx)
    input = args[:input]
    return unless input

    user = User.find_by(email: input[:email].downcase)
    return unless user
    return unless user.valid_password?(input[:password])

    OpenStruct.new({
      token: AuthToken.token(user),
      user: user
    })
  end
end
