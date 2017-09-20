Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {

      if ctx[:current_user].blank?
        raise GraphQL::ExecutionError.new("Authentication required")
      end

      "Hello World!"
    }
  end

  field :user do
    type Types::UserType
    argument :id, !types.ID
    description "Find a user by id"
    resolve ->(obj, args, ctx) {

      begin
        User.find(args[:id])
      rescue ActiveRecord::RecordNotFound
        raise GraphQL::ExecutionError.new("No User found with ID #{args[:id]}")
      end

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

  field :users, !types[Types::UserType] do
    argument :byPoints, types.Boolean, default_value: false

    argument :limit, types.Int, default_value: 20,
             prepare: -> (limit, ctx) { [limit, 30].min }
    resolve -> (obj, args, ctx) {

      if args[:byPoints]
        User.limit(args[:limit]).order(points: :desc)
      else
        User.limit(args[:limit]).order(id: :desc)
      end
    }
  end


end
