# frozen_string_literal: true

module Jwt
  module Encoder
    module_function

    def call(user_id, refresh_token = nil)
      time = Time.now.to_i
      payload = {
        user_id:,
        exp: time + Jwt::Meta::ACCESS_EXP
      }

      if refresh_token
        payload.merge!(jti: refresh_token.jti)
        payload[:exp] = time + Jwt::Meta::REFRESH_EXP
      end

      JWT.encode(payload, Jwt::Meta::HMAC_SECRET, Jwt::Meta::ALGO)
    end
  end
end
