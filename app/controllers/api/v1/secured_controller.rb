class Api::V1::SecuredController < ActionController::API
  #   before_action :authorize_request
  #   skip_before_action :authorize_request, only: [:request_session]

  def request_session
    render json: {
      domain: Rails.application.credentials.auth0[:domain],
      clientId: "J7rHoji5WHs8ZIK3tVGQOG50RiU4hXWY",
    }
  end

  private

  def authorize_request
    AuthorizationService.new(request.headers).authenticate_request!
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ["Not Authenticated"] }, status: :unauthorized
  end
end
