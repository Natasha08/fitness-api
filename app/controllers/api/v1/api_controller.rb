module API::V1
  class APIController < ApplicationController
    class UnprocessableEntityError < StandardError; end
    rescue_from UnprocessableEntityError, with: :render_422_error
    rescue_from ActionController::ParameterMissing, with: :render_422_error

    private

    def render_422_error exception
      render json: {error: exception.message}, status: 422
    end
  end
end
