# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/progressions", type: :request do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  let(:endpoint) { "/progressions" }

  describe "GET /" do
    it "returns ok" do
      authorized_get(user, endpoint)

      expect(response).to have_http_status(:ok)
    end

    context "when profile has no progressions" do
      it "returns empty array" do
        authorized_get(user, endpoint)

        expect(response.parsed_body).to eq([])
      end
    end

    context "when profile has progressions" do
      let!(:progressions) do
        create(:progression)

        [
          create(:progression, profile:),
          create(:progression, profile:)
        ]
      end

      it "returns progressions associated to user" do
        authorized_get(user, endpoint)

        expect(response.parsed_body.count).to eq(2)
        expect(response.parsed_body.pluck("id")).to match_array(progressions.pluck(:id))
      end
    end
  end

  describe "POST /" do
  end
end
