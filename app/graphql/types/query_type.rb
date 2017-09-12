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

  field :lmarker do
    type Types::LmarkerType
    argument :id, !types.ID
    description "Find an Lmarker by id"
    resolve ->(obj, args, ctx) { Lmarker.find(args["id"]) }
  end


  field :lmarkers, !types[Types::LmarkerType] do
    argument :limit, types.Int, default_value: 20,
             prepare: -> (limit, ctx) { [limit, 30].min }
    resolve -> (obj, args, ctx) {
      Lmarker.limit(args[:limit]).order(id: :desc)
    }
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
