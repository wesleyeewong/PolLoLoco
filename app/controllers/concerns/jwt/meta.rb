module Jwt
  module Meta
    ALGO = "HS256"
    HMAC_SECRET = ENV["JWT_HMAC_SECRET"]
    ACCESS_EXP = 15.minutes
    REFRESH_EXP = 14.days
  end
end
