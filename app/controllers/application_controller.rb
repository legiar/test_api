class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :param_missing
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

    def error(status, message = nil)
      render json: { error: message }, status: status
    end

    def param_missing(exception)
      param = exception.message[/(?<=\: ).+/]
      error(:bad_request, "missing param '#{param}")
    end

    def not_found(message = 'not_found')
      message = message.message if message.is_a? ActiveRecord::RecordNotFound
      render json: { error: message }, status: :not_found
    end

end
