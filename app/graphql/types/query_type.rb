Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end

  field :lmarkers do
    type Types::LmarkerType
    argument :id, !types.ID
    description "Find an Lmarker by id"
    resolve ->(obj, args, ctx) { Lmarker.find(args["id"]) }
  end

  # query {
  #   testField
  #   lmarkers (id:39){
  #     id
  #     lat
  #     lng
  #   }
  # }


end
