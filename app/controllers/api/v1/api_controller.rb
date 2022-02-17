module API::V1
  class APIController <  ActionController::API
    class UnprocessableEntityError < StandardError; end
    rescue_from UnprocessableEntityError, with: :render_422_error
    rescue_from ActionController::ParameterMissing, with: :render_422_error
    before_action :authorize_request, except: :login

    private

    def render_422_error exception
      render json: {error: exception.message}, status: 422
    end

    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end
end
