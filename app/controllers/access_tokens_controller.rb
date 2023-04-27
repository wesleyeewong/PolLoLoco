# frozen_string_literal: true

class AccessTokensController < ApplicationController
  skip_before_action :authenticate_user

  def create
    @decoded_token = Jwt::Decoder.call(authorization_token, :refresh)

    old_refresh_token.destroy!

    render json: { access_token: access_token, refresh_token: new_refresh_token }, status: :created
  end

  private

  attr_reader :decoded_token

  def old_refresh_token
    @old_refresh_token ||= RefreshToken.find_by(user_id: decoded_token[:user_id], jti: decoded_token[:jti])
  end

  def new_refresh_token
    @new_refresh_token ||=
      Jwt::Encoder.call(
        decoded_token[:user_id],
        RefreshToken.create(user_id: decoded_token[:user_id], jti: RefreshToken.new_jti)
      )
  end

  def access_token
    @access_token ||= Jwt::Encoder.call(decoded_token[:user_id])
  end
end
