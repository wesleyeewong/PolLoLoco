# frozen_string_literal: true

module Jwt
  module Meta
    ALGO = "HS256"
    HMAC_SECRET = ENV.fetch("JWT_HMAC_SECRET", nil)
    ACCESS_EXP = 15.minutes
    REFRESH_EXP = 14.days
  end
end
