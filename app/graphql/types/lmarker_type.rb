Types::LmarkerType = GraphQL::ObjectType.define do
  name "Lmarker"
  field :id, !types.ID
  field :lat, !types.Float
  field :lng, !types.Float
  # field :name, !types.String
  # field :avatar, Types::PhotoType
end