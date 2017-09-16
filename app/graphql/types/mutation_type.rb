Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, function: Mutations::CreateUser.new
  field :signInUser, function: Mutations::SignInUser.new
  field :placeLmarker, function: Mutations::PlaceLmarker.new
end
