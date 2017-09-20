class Mutations::RemoveLmarker < GraphQL::Function
  argument :id, types.Int

  type types.String

  def call(_obj, args, ctx)

    if ctx[:current_user].blank?
      raise GraphQL::ExecutionError.new("Authentication required")
    end


    user = ctx[:current_user]

    lmarker = Lmarker.find_by(user_id:user.id,
                             id: args[:id])

    if lmarker == nil
      raise GraphQL::ExecutionError.new("No Lmarker with ID #{args[:id]} & user ID #{user.id} found.")
    else
      lmarker.delete
    end

    'Success'

  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end