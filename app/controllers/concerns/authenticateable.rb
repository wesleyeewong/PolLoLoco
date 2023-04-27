# frozen_string_literal: true

module Authenticateable
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authorization_token_presence
    before_action :authenticate_user

    rescue_from JWT::ExpiredSignature, JWT::InvalidJtiError, JWT::DecodeError, JWT::VerificationError,
      with: proc { head :unauthorized }
  end

  private

  def ensure_authorization_token_presence
    raise JWT::VerificationError unless authorization_token
  end

  def authenticate_user
    decoded_token = Jwt::Decoder.call(authorization_token)

    @current_user = User.find(decoded_token.fetch(:user_id))

  rescue ActiveRecord::RecordNotFound
    head :unauthorized
  end

  def authorization_token
    @authorization_token ||= request.headers["Authorization"]&.split(" ")&.last
  end
end
