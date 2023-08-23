class Auth::GoogleController < ApplicationController
  skip_before_action :authenticate_user

  CLIENT_ID = ENV.fetch("GOOGLE_CLIENT_ID", nil)

  def create
    begin
      data = Google::Auth::IDTokens.verify_oidc(oauth_token, aud: CLIENT_ID)
      email = data["email"]
      user = User.find_or_initialize_by(email: email)

      if user.new_record?
        user.name = data["given_name"]
        user.build_profile(name: data["given_name"])
        user.save!
      end

      access_token = Jwt::Encoder.call(user.id)
      refresh_token = Jwt::Encoder.call(user.id, RefreshToken.create(user_id: user.id, jti: RefreshToken.new_jti))

      render json: { access_token:, refresh_token: }, status: :ok
    rescue StandardError => e
      head :unauthorized
    end
  end

  private

  def oauth_token
    params[:oauth_token]
  end
end
