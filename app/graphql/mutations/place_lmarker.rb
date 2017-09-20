class Mutations::PlaceLmarker < GraphQL::Function
  #pass in a dict clientside instead
  argument :input, !Types::PlaceLmarkerInput


  type Types::LmarkerType

  def call(_obj, args, ctx)

    if ctx[:current_user].blank?
      raise GraphQL::ExecutionError.new("Authentication required")
    end
    input = args[:input]

    user = ctx[:current_user]

    lmarker = Lmarker.create(user_id:user.id,
    lat: input[:lat],
    lng: input[:lng],
    ltype: input[:ltype])


    RpsWorker.new.perform

    lmarker  #return

  rescue ActiveRecord::RecordNotFound => e
    GraphQL::ExecutionError.new("No Lmarker with user ID #{1} found.")
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end