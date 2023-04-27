# frozen_string_literal: true

module Jwt
  module Decoder
    module_function

    def call(token, type = :access)
      opts = { algorightm: Jwt::Meta::ALGO }
      opts.merge!(verify_jti: proc { |jti, payload| verify_jti(payload["user_id"], jti) }) if type == :refresh

      decoded = JWT.decode(token, Jwt::Meta::HMAC_SECRET, true, opts)

      decoded.first.symbolize_keys!
    end

    def verify_jti(user_id, jti)
      RefreshToken.where(user_id: user_id, jti: jti).any?
    end
  end
end
