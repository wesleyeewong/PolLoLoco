# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/access_tokens", type: :request do
  let(:user) { create(:user) }

  describe "POST /" do
    let(:endpoint) { "/access_tokens" }
    let!(:refresh_token) { create(:refresh_token, user:) }
    let(:encoded_refresh_token) { Jwt::Encoder.call(user.id, refresh_token) }
    let(:headers) { { "Authorization" => "Bearer #{encoded_refresh_token}" } }

    context "when no authorization token passed in" do
      it "responds with unauthorized" do
        post endpoint

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when invalid refresh token passed in" do
      it "responds with unauthorized" do
        post(endpoint, headers: { "Authorization" => "Bearer InvalidToken" })

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when authorization token passed in" do
      let(:authorization_token) { Jwt::Encoder.call(user.id) }

      it "responds with unauthorized" do
        expect(Jwt::Decoder.call(authorization_token)).to match(user_id: user.id, exp: an_instance_of(String))

        post(endpoint, headers: { "Authorization" => "Bearer #{authorization_token}" })

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when expired refresh token passed in" do
      let!(:encoded_refresh_token) { Jwt::Encoder.call(user.id, refresh_token) }

      it "responds with unauthorized" do
        travel(Jwt::Meta::REFRESH_EXP + 1.day) do
          post(endpoint, headers:)

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    it "responds with created status" do
      post(endpoint, headers:)

      expect(response).to have_http_status(:created)
    end

    it "responds with valid access and refresh token" do
      post(endpoint, headers:)

      expect(response.parsed_body)
        .to match("access_token" => an_instance_of(String), "refresh_token" => an_instance_of(String))

      expect(Jwt::Decoder.call(response.parsed_body["access_token"]))
        .to match(user_id: user.id, exp: an_instance_of(String))

      expect(Jwt::Decoder.call(response.parsed_body["refresh_token"]))
        .to match(user_id: user.id, exp: an_instance_of(String), jti: an_instance_of(String))
    end

    it "responds with new refresh token" do
      post(endpoint, headers:)

      expect(response.parsed_body["refresh_token"]).not_to match(encoded_refresh_token)
    end

    it "destroys old refresh token, and creates a new one" do
      expect(user.refresh_tokens.count).to eq(1)

      old_refresh_token_jti = user.refresh_tokens.first.jti

      post(endpoint, headers:)

      expect(user.refresh_tokens.count).to eq(1)

      expect(user.refresh_tokens.first.jti).not_to eq(old_refresh_token_jti)
    end
  end
end
