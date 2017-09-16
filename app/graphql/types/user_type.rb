Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  field :id, !types.ID
  field :email, !types.String
  field :name, !types.String

  # field :lmarkers, !types[Types::LmarkerType] do
  #   preload :lmarkers
  #   resolve -> (obj, args, ctx) { obj.lmarkers }
  # end

end
