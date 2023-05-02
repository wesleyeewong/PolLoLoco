# frozen_string_literal: true

require "rails_helper"

RSpec.shared_examples(:authenticateable) do |verb:, endpoint:|
  context "when no access token" do
    it "returns unauthorized when no access token" do
      send(verb, endpoint)

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when invalid access token" do
    it "returns unauthorized access" do
      send(verb, endpoint, headers: { Authorization: "Bearer invalid" })

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
