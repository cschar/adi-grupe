class Mutations::CreateUser < GraphQL::Function
  # argument :name, !types.String
  argument :input, !Types::AuthProviderEmailInput

  type Types::AuthenticateType

  def call(_obj, args, _ctx)
    user = User.create!(
      email: args[:input][:email].downcase,
      password: args[:input][:password]
    )

    OpenStruct.new({
      token: AuthToken.token(user),
      user: user
    })
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
