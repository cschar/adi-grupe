Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  field :id, !types.ID
  field :email, !types.String

  # generate when user is made
  # https://github.com/usmanbashir/haikunator
  # field :name, !types.String
  field :points, !types.Int

  field :lmarkers, !types[Types::LmarkerType] do
    # preload :lmarkers
    resolve -> (obj, args, ctx) { obj.lmarkers }
  end

end
