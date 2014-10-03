class Api::V1Controller < ApplicationController
  skip_before_filter :verify_authenticity_token

  rescue_from ArgumentError,              with: :argument_error
  # rescue_from Pundit::NotAuthorizedError, with: :access_denied_error

  private

    def argument_error(error)
      render json: {
        error:   error.message,
      }, status: :bad_request
    end

    def access_denied_error
      render json: {
        error:   'Access denied',
      }, status: :unauthorized
    end

end
