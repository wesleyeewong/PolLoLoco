# frozen_string_literal: true

module Authenticateable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user

    rescue_from JWT::ExpiredSignature, JWT::InvalidJtiError, JWT::DecodeError, JWT::VerificationError,
                with: proc { head :unauthorized }
  end

  private

  def authenticate_user
    raise JWT::VerificationError unless authorization_token

    decoded_token = Jwt::Decoder.call(authorization_token)

    Current.user = User.includes(:profile).find(decoded_token.fetch(:user_id))
    Current.profile = Current.user.profile
  rescue ActiveRecord::RecordNotFound
    head :unauthorized
  end

  def authorization_token
    @authorization_token ||= request.headers["Authorization"]&.split(" ")&.last
  end
end
