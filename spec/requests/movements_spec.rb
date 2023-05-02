# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/movements", type: :request do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  let(:endpoint) { "/movements" }
  let!(:movements) do
    [create(:movement), create(:movement)]
  end

  describe "GET /" do
    it_behaves_like(:authenticateable, verb: :get, endpoint: "/movements")

    it "returns ok" do
      authorized_get(user, endpoint)

      expect(response).to have_http_status(:ok)
    end

    it "returns array of movements" do
      authorized_get(user, endpoint)

      expect(response.parsed_body.pluck("id")).to match(movements.pluck(:id))
      expect(response.parsed_body.pluck("slug")).to match(movements.pluck(:slug))
    end
  end
end
