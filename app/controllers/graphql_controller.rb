class GraphqlController < ApplicationController

  #TODO replace w JWT verification
  skip_before_action :verify_authenticity_token

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user: current_user,
    }
    result = RailsReactSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  # use this above and add :current_user to context
  def current_user
    puts 'Authroization header sent ------->'
    puts request.headers['Authorization']

    return nil if request.headers['Authorization'].blank?
    token = request.headers['Authorization'].split(' ').last
    return nil if token.blank?

    begin
      Base64.decode64(token) # decode data
    rescue ArgumentError => e
      if Rails.env.development?
           puts 'Invalid base64 sent in token'
      end
      return nil
    end

    puts 'verifying authroization token'
    result = AuthToken.verify(token)

  end

end
