class Api::V1::BaseController < ActionController::API
  include Pundit

  before_action :authorize_request
  before_action :set_current_user, except: [:request_session]
  after_action :verify_authorized, except: [:index, :request_session]
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  skip_before_action :authorize_request, only: [:request_session]

  def request_session
    token = GenerateToken.perform
    if token
      render json: { token: token[:access_token] }
    else
      render json: { status: 500 }
    end
  end

  def set_current_user
    # token = retrieve_token
    @user ||= User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    raise Pundit::NotAuthorizedError unless @user
    # && @user.token == token
  end

  def pundit_user
    @user
  end

  private

  def retrieve_token
    request.headers["Authorization"].split(" ").last
  end

  def authorize_request
    AuthorizationService.new(request.headers).authenticate_request!
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ["Not Authenticated"] }, status: :unauthorized
  end

  def user_not_authorized(exception)
    render json: {
             error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}",
           }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_error(record)
    render json: { errors: record.errors.full_messages },
      status: :unprocessable_entity
  end
end
