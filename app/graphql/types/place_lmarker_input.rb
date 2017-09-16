Types::PlaceLmarkerInput = GraphQL::InputObjectType.define do
  name 'PLACE_LMARKER'

  argument :id, types.Int  #optional for PUT/PATCH

  argument :lat, !types.Float
  argument :lng, !types.Float
  argument :ltype, !types.String
end
